package com.nicico.sales.dto.report;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReportFieldDTO {

    private String name;
    private String titleFA;
    private String titleEN;
    private String title;
    private String type;
    private Boolean hidden;
    private Boolean canFilter;
    private Long reportId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportFieldInfo")
    public static class Info extends ReportFieldDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportFieldCreateRq")
    public static class Create extends ReportFieldDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportFieldUpdateRq")
    public static class Update extends ReportFieldDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportFieldDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
