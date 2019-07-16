package com.nicico.sales.config;

import com.nicico.copper.core.AbstractExceptionHandlerControllerAdvice;
import com.nicico.copper.core.dto.ErrorResponseDTO;
import com.nicico.copper.core.util.IErrorCode;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@ControllerAdvice
public class SalesExceptionHandlerControllerAdvice extends AbstractExceptionHandlerControllerAdvice {

    @Override
    protected Map<String, ErrorResponseDTO.ErrorFieldDTO> getUniqueConstraintErrors() {
        Map<String, ErrorResponseDTO.ErrorFieldDTO> errorCodeMap = new HashMap<>();
        errorCodeMap.put("fk", new ErrorResponseDTO.ErrorFieldDTO().setCode("DataIntegrityViolation"));
        errorCodeMap.put("uk", new ErrorResponseDTO.ErrorFieldDTO().setCode("DataIntegrityViolation_Unique"));
        return errorCodeMap;
    }

    @ExceptionHandler({DataIntegrityViolationException.class})
    public ResponseEntity<Object> handleDataIntegrityViolationException(DataIntegrityViolationException ex) {
        this.printLog(ex, true, true);
        ConstraintViolationException cve = (ConstraintViolationException) ex.getCause();
        if (cve.getConstraintName() != null) {
            String constraint = cve.getConstraintName().toLowerCase();
            Optional<ErrorResponseDTO.ErrorFieldDTO> first = this.getUniqueConstraintErrors().entrySet().stream().filter((entry) -> {
                return constraint.contains(entry.getKey());
            }).map(Map.Entry::getValue).findFirst();
            ErrorResponseDTO.ErrorFieldDTO statusCode = first.orElse(new ErrorResponseDTO.ErrorFieldDTO());
            ErrorResponseDTO errorResponseDTO = (new ErrorResponseDTO(ex)).setError(statusCode.getCode()).setErrors(Collections.singleton((new ErrorResponseDTO.ErrorFieldDTO()).setField(statusCode.getField()).setCode(statusCode.getCode()).setMessage(statusCode.getMessage())));
            return new ResponseEntity(errorResponseDTO, HttpStatus.BAD_REQUEST);
        } else {
            return this.handleException(cve);
        }
    }

    @ExceptionHandler({MaxUploadSizeExceededException.class})
    public ResponseEntity<Object> handleFileSizeLimitExceeded(MaxUploadSizeExceededException ex) {
        this.printLog(ex, true, true);
        return this.createGeneralResponseEntity(ex, IErrorCode.Unknown); // 400 Bad Request is better
    }
}
