package com.nicico.sales.config;

import com.nicico.copper.common.AbstractExceptionHandlerControllerAdvice;
import com.nicico.copper.common.dto.ErrorResponseDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.*;
import io.minio.errors.ErrorResponseException;
import io.minio.messages.ErrorResponse;
import lombok.RequiredArgsConstructor;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.exception.DataException;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import javax.persistence.PersistenceException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    private Throwable findConstraintViolationException(Throwable exception) {

        Throwable result = null;
        Throwable throwable = exception;
        while (throwable != null) {

            if (throwable instanceof javax.validation.ConstraintViolationException) {

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

        Throwable throwable = findBaseException(exception);
        if (throwable instanceof BaseException) {

            BaseException originalException = (BaseException) throwable;
            HttpStatus httpStatus = HttpStatus.valueOf(originalException.getResponse().getErrorCode().getId());
            return new ResponseEntity<>(createErrorResponseDTO(originalException), httpStatus);
        }
        throwable = findConstraintViolationException(exception);
        if (throwable instanceof javax.validation.ConstraintViolationException) {
/*
ConstraintViolationImpl{
    interpolatedMessage='شناسه محصول خالی نباشد',
     propertyPath=label,
     rootBeanClass=class com.nicico.sales.model.entities.warehouse.Inventory,
      messageTemplate='شناسه محصول خالی نباشد'
      }
*/
            String field = null, message = null, msgRegex = "interpolatedMessage='(.*?)'", fieldRegex = "propertyPath=(.*?),";
            final Pattern msgPattern = Pattern.compile(msgRegex);
            final Pattern fieldPattern = Pattern.compile(fieldRegex);
            javax.validation.ConstraintViolationException originalException = (javax.validation.ConstraintViolationException) throwable;
            Matcher matcher = fieldPattern.matcher(originalException.getLocalizedMessage());
            if (matcher.find())
                field = matcher.group(1);
            matcher = msgPattern.matcher(originalException.getLocalizedMessage());
            if (matcher.find()) {

                final Locale locale = LocaleContextHolder.getLocale();
                message = messageSource.getMessage(matcher.group(1), null, locale);
            }

            return new ResponseEntity<>(createErrorResponseDTO(new SalesException2(ErrorType.ConstraintViolation, field, message)), HttpStatus.INTERNAL_SERVER_ERROR);
        }
        if (throwable instanceof ErrorResponseException) {

            ErrorResponse errorResponse = ((ErrorResponseException) throwable).errorResponse();
            final String message = errorResponse.message();
            return new ResponseEntity<>(createErrorResponseDTO(new SalesException2(ErrorType.InternalServerError, null, message)), HttpStatus.INTERNAL_SERVER_ERROR);
        }
        if (exception instanceof RestClientException) {
            final Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage("exception.other.system.call.unauthorized", null, locale);
            if (exception instanceof HttpClientErrorException.Unauthorized)
                return new ResponseEntity<>(createErrorResponseDTO(new SalesException2(ErrorType.Unknown, null, message)), HttpStatus.NOT_FOUND);
            message = messageSource.getMessage("exception.other.system.call.notfound", null, locale);
            if (exception instanceof HttpClientErrorException.NotFound)
                return new ResponseEntity<>(createErrorResponseDTO(new SalesException2(ErrorType.Unknown, null, message)), HttpStatus.NOT_FOUND);
        }
        final Locale locale = LocaleContextHolder.getLocale();
        String message = messageSource.getMessage("exception.un-managed", null, locale);
        ErrorResponseDTO errorResponseDTO = new ErrorResponseDTO(exception).
                setError(ErrorType.Unknown.name()).
                setErrors(Collections.singleton((new ErrorResponseDTO.ErrorFieldDTO()).
                        setCode(ErrorType.Unknown.name()).
                        setMessage(message)));

        return new ResponseEntity<>(errorResponseDTO, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler({SalesException2.class, NotFoundException.class, DeActiveRecordException.class, FinalRecordException.class, NotEditableException.class, UnAuthorizedException.class})
    public ResponseEntity<Object> handleBaseExceptions(BaseException exception) {

        this.printLog(exception, true, true, exception.getResponse().toString());
        return provideStandardError(exception);
    }

    @ExceptionHandler(ErrorResponseException.class)
    public ResponseEntity<Object> handleErrorResponseException(ErrorResponseException exception) {

        this.printLog(exception, true, true, exception.errorResponse().toString());
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

    @ExceptionHandler({ObjectOptimisticLockingFailureException.class})
    public ResponseEntity<Object> handleObjectOptimisticLockingFailureException(ObjectOptimisticLockingFailureException exception) {
        this.printLog(exception, true, true, exception.getClass().getName());

        Locale locale = LocaleContextHolder.getLocale();
        String message = messageSource.getMessage("exception.optimistic-locking-failure", null, locale);
        return provideStandardError(new SalesException2(ErrorType.BadRequest, null, message));
    }

    @ExceptionHandler({PersistenceException.class})
    public ResponseEntity<Object> handlePersistenceExceptionException(PersistenceException ex) {
        return handleDataIntegrityViolationAndPersistenceException(ex);
    }

    @ExceptionHandler({DataIntegrityViolationException.class})
    public ResponseEntity<Object> handleDataIntegrityViolationException(DataIntegrityViolationException ex) {
        return handleDataIntegrityViolationAndPersistenceException(ex);
    }

    private ResponseEntity<Object> handleDataIntegrityViolationAndPersistenceException(Exception ex) {

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
