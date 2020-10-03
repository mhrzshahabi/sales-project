package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Collection;

@Getter
@Setter
@Accessors(chain = true)
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ErrorResponseDTO {
	private String exceptionClass;
	private String message;
	private String error;
	private Collection<ErrorFieldDTO> errors;

	public ErrorResponseDTO(Exception ex) {
		this.exceptionClass = ex.getClass().getName();
	}


	@Getter
	@Setter
	@Accessors(chain = true)
	@NoArgsConstructor
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class ErrorFieldDTO {
		private String field;
		private String code;
		private String message;
	}

	public static ErrorFieldDTO of(String field, String code) {
		return new ErrorFieldDTO().setField(field).setCode(code);
	}
}
