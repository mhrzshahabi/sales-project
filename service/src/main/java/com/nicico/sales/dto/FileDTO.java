package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class FileDTO {

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("FileRequest")
	public static class Request {
		private EFileAccessLevel accessLevel;
		private MultipartFile file;
		private String tags;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("FileResponse")
	public static class Response {
		private byte[] content;
		private String fileName;
		private String extension;
		private String contentType;
		private Map<String, String> tags;
	}
}
