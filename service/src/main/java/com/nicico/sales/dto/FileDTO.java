package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.sales.model.enumeration.EFileStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;
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
        @NotNull
        @ApiModelProperty(required = true)
        private EFileAccessLevel accessLevel;
        private String permissions;
        @NotNull
        @ApiModelProperty(required = true)
        private MultipartFile file;
        private String tags;
        @NotEmpty
        @ApiModelProperty(required = true)
        private String entityName;
        @NotNull
        @ApiModelProperty(required = true)
        private Long recordId;
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
        private EFileAccessLevel accessLevel;
        private String permissions;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("FileData")
    public static class FileData extends FileMetaData {
        private MultipartFile file;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("FileMetaData")
    public static class FileMetaData {
        private Long id;
        private Long recordId;
        private String entityName;
        private String fileKey;
        private EFileStatus fileStatus;
        private EFileAccessLevel accessLevel;
        private String permissions;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("FileMetaDataDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
