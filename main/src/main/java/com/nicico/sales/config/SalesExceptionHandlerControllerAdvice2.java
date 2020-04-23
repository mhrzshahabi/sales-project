package com.nicico.sales.config;

import com.nicico.copper.common.AbstractExceptionHandlerControllerAdvice;
import com.nicico.copper.common.dto.ErrorResponseDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.*;
import com.nicico.sales.model.annotation.EntityConstraint;
import com.nicico.sales.utility.MessageKeyUtil;
import lombok.RequiredArgsConstructor;
import org.hibernate.exception.ConstraintViolationException;
import org.reflections.Reflections;
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
public class SalesExceptionHandlerControllerAdvice2 extends AbstractExceptionHandlerControllerAdvice {

    private final ResourceBundleMessageSource messageSource;
    private static final List<EntityConstraint> uniqueConstraintAnnotations = new ArrayList<>();

    static {

        final Reflections reflections = new Reflections("com.nicico.sales.model");
        Set<Class<?>> allModels = reflections.getTypesAnnotatedWith(EntityConstraint.class);
        allModels.forEach(item -> uniqueConstraintAnnotations.addAll(Arrays.asList(item.getDeclaredAnnotationsByType(EntityConstraint.class))));
    }

    @Override
    protected Map<String, ErrorResponseDTO.ErrorFieldDTO> getUniqueConstraintErrors() {

        final Locale locale = LocaleContextHolder.getLocale();
        final Map<String, ErrorResponseDTO.ErrorFieldDTO> uniqueConstraintErrors = new HashMap<>();
        for (EntityConstraint annotation : uniqueConstraintAnnotations) {

            final String messageKey = MessageKeyUtil.makeMessageKey(annotation.constraintType().name());
            final String message = messageSource.getMessage("exception." + messageKey + "constraint",
                    new Object[]{String.join(", ", annotation.constraintFields())}, locale);
            ErrorResponseDTO.ErrorFieldDTO error = new ErrorResponseDTO.ErrorFieldDTO();
            error.setField(String.join(",", annotation.constraintFields()));
            error.setCode(ErrorType.BadRequest.getId().toString());
            error.setMessage(message);

            uniqueConstraintErrors.put(annotation.constraintName(), error);
        }

        return uniqueConstraintErrors;
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

    @ExceptionHandler({
            SalesException2.class,
            NotFoundException.class,
            NotEditableException.class,
            UnAuthorizedException.class
    })
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
        } else
            return this.handleException(constraintViolationException);
    }
}