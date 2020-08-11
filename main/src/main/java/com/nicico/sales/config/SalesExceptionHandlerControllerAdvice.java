package com.nicico.sales.config;

import com.nicico.copper.common.AbstractExceptionHandlerControllerAdvice;
import com.nicico.copper.common.dto.ErrorResponseDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.*;
import lombok.RequiredArgsConstructor;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.exception.DataException;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import java.util.*;

@ControllerAdvice
@RequiredArgsConstructor
public class SalesExceptionHandlerControllerAdvice extends AbstractExceptionHandlerControllerAdvice {

    private final ResourceBundleMessageSource messageSource;

    @Override
    protected Map<String, ErrorResponseDTO.ErrorFieldDTO> getUniqueConstraintErrors() {

        Map<String, ErrorResponseDTO.ErrorFieldDTO> errorCodeMap = new HashMap<>();
        errorCodeMap.put("fk_", new ErrorResponseDTO.ErrorFieldDTO().setCode("DataIntegrityViolation_FK"));
        errorCodeMap.put("2", new ErrorResponseDTO.ErrorFieldDTO().setCode("DataIntegrityViolation_FK"));
        errorCodeMap.put("uk_", new ErrorResponseDTO.ErrorFieldDTO().setCode("DataIntegrityViolation_Unique"));
        errorCodeMap.put("uc_", new ErrorResponseDTO.ErrorFieldDTO().setCode("DataIntegrityViolation_Unique"));
        errorCodeMap.put("unique", new ErrorResponseDTO.ErrorFieldDTO().setCode("DataIntegrityViolation_Unique"));
        return errorCodeMap;
    }

    private Throwable findBaseException(Throwable exception) {

        Throwable result = null;
        Throwable throwable = exception;
        while (throwable != null) {

            if (throwable instanceof BaseException) {

                result = throwable;
                break;
            }

            throwable = throwable.getCause();
        }

        return result;
    }

    private ErrorResponseDTO createErrorResponseDTO(BaseException exception) {

        return (new ErrorResponseDTO(exception)).
                setError(exception.getResponse().getErrorCode().name()).
                setErrors(Collections.singleton((new ErrorResponseDTO.ErrorFieldDTO()).
                        setField(exception.getResponse().getField()).
                        setMessage(exception.getResponse().getMessage()).
                        setCode(exception.getResponse().getErrorCode().name())));
    }

    private ResponseEntity<Object> provideStandardError(Exception exception) {

        Throwable baseException = findBaseException(exception);
        if (baseException instanceof BaseException) {

            BaseException originalException = (BaseException) baseException;
            HttpStatus httpStatus = HttpStatus.valueOf(originalException.getResponse().getErrorCode().getId());
            return new ResponseEntity<>(createErrorResponseDTO(originalException), httpStatus);
        } else {

            final Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage("exception.un-managed", null, locale);
            ErrorResponseDTO errorResponseDTO = new ErrorResponseDTO(exception).
                    setError(ErrorType.Unknown.name()).
                    setErrors(Collections.singleton((new ErrorResponseDTO.ErrorFieldDTO()).
                            setCode(ErrorType.Unknown.name()).
                            setMessage(message)));

            return new ResponseEntity<>(errorResponseDTO, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ExceptionHandler({SalesException2.class, NotFoundException.class, DeActiveRecordException.class, FinalRecordException.class, NotEditableException.class, UnAuthorizedException.class})
    public ResponseEntity<Object> handleBaseExceptions(BaseException exception) {

        this.printLog(exception, true, true, exception.getResponse().toString());
        return provideStandardError(exception);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Object> handleException(Exception exception) {

        this.printLog(exception, true, true, exception.getClass().getName());
        return provideStandardError(exception);
    }

    @Override
    @ExceptionHandler({AccessDeniedException.class})
    public ResponseEntity<Object> handleAccessDenied(AccessDeniedException exception) {

        this.printLog(exception, true, true, exception.getClass().getName());
        return provideStandardError(new UnAuthorizedException(exception, null));
    }

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ResponseEntity<Object> handleMaxUploadSizeExceededException(MaxUploadSizeExceededException exception) {

        this.printLog(exception, true, true, exception.getClass().getName());

        Locale locale = LocaleContextHolder.getLocale();
        String message = messageSource.getMessage("exception.max-up-size-exceeded", new Object[]{exception.getMaxUploadSize()}, locale);
        return provideStandardError(new SalesException2(ErrorType.PayloadTooLarge, null, message));
    }

    @ExceptionHandler({DataIntegrityViolationException.class})
    public ResponseEntity<Object> handleDataIntegrityViolationException(DataIntegrityViolationException ex) {

        this.printLog(ex, true, true, ex.getClass().getName());

        if (ex.getCause() instanceof ConstraintViolationException) {

            ConstraintViolationException constraintViolationException = (ConstraintViolationException) ex.getCause();
            if (constraintViolationException.getConstraintName() != null) {

                String constraintName = constraintViolationException.getConstraintName().toLowerCase();
                Optional<ErrorResponseDTO.ErrorFieldDTO> first = this.getUniqueConstraintErrors().entrySet().stream().
                        filter((entry) -> constraintName.contains(entry.getKey())).
                        map(Map.Entry::getValue).findFirst();
                ErrorResponseDTO.ErrorFieldDTO errorDTO = first.orElse(new ErrorResponseDTO.ErrorFieldDTO());
                ErrorResponseDTO errorResponseDTO = (new ErrorResponseDTO(ex)).
                        setError(errorDTO.getCode()).
                        setErrors(Collections.singleton((new ErrorResponseDTO.ErrorFieldDTO()).
                                setCode(errorDTO.getCode()).
                                setField(errorDTO.getField()).
                                setMessage(errorDTO.getMessage())));

                return new ResponseEntity<>(errorResponseDTO, HttpStatus.BAD_REQUEST);
            } else return this.handleException(constraintViolationException);
        } else if (ex.getCause() instanceof DataException)
            return provideStandardError(new InvalidDataException(ex, null));

        return provideStandardError(ex);
    }
}
