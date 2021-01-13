package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.sales.model.enumeration.EFileStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.http.ContentDisposition;
import org.springframework.http.MediaType;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class StorageDTO {
    private Integer status;
    private String message;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("StoreResponse")
    public static class StoreResponse extends StorageDTO {
        private String key;
        private Map<String, Object> tags;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InfoResponse")
    public static class RetrieveResponse {
        private byte[] content;
        private Long contentLength;
        private MediaType contentType;
        private ContentDisposition contentDisposition;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InfoResponse")
    public static class InfoResponse extends StorageDTO {
        private String originalName;
        private String uuid;
        private Integer size;
        private Boolean active;
        private List<Tag> tags;
        private String uploadedBy;
        private Date timestamp;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("SearchResponse")
    public static class SearchResponse extends StorageDTO {
        private List<InfoResponse> files;
        private Integer totalPages;
        private Integer totalElements;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TagResponse")
    public static class TagResponse extends StorageDTO {
        private List<Tag> tags;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("Tag")
    public static class Tag {
        private String key;
        private Object value;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RetrieveResponseInApp")
    public static class RetrieveResponseInApp extends RetrieveResponse {
        private String name;
        List<StorageDTO.Tag> tagsResponse;
    }
}
