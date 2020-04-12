package com.nicico.sales;

import com.nicico.copper.common.IErrorCode;
import com.nicico.copper.common.NICICOException;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.web.servlet.HandlerInterceptor;

@Getter
public class EvaluationException extends NICICOException implements HandlerInterceptor {

	@Getter
	@RequiredArgsConstructor
	public enum ErrorType implements IErrorCode {

		NotFound(404),
		Unknown(500),
		Unauthorized(401),
        Forbidden(403),
		RecordAlreadyExists(405),
		UpdatingInvalidOldVersion(400);

		private final Integer httpStatusCode;

		@Override
		public String getName() {
			return name();
		}
	}

	@Getter
	@Setter(AccessLevel.PRIVATE)
	private String message;

	// ------------------------------

	public EvaluationException(IErrorCode errorCode) {
		super(errorCode);
	}

	public EvaluationException(ErrorType errorCode) {
		this(errorCode, null);
	}
	public EvaluationException(ErrorType errorCode, String field) {
		super(errorCode, field);
	}
	public EvaluationException(ErrorType errorCode, String field, String message) {
		super(errorCode, field);
		setMessage(message);
	}
}