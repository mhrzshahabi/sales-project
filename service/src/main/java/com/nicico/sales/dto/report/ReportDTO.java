package com.nicico.sales.dto.report;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.ReportSource;
import com.nicico.sales.model.enumeration.ReportType;
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
public class ReportDTO {

    private String titleFA;
    private String titleEN;
    private String title;
    private String nameFA;
    private String nameEN;
    private String name;
    private String source;
    private String restMethod;
    private String permissionBaseKey;
    private ReportType reportType;
    private ReportSource reportSource;
    private Long reportGroupId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("FieldData")
    public static class FieldData {

        private String name;
        private String className;
        private String titleFA;
        private String titleEN;
        private String type;
        private Boolean hidden;
        private Boolean canFilter;
        private Boolean dataIsList;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("RestData")
    public static class SourceData {

        private String source;
        private String nameFA;
        private String nameEN;
        private String name;
        private String restMethod;
        private Boolean dataIsList;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportInfo")
    public static class Info extends ReportDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        private ReportGroupDTO.Info reportGroup;
        private List<ReportFieldDTO.Info> reportFields;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportCreateRq")
    public static class Create extends ReportDTO {

        private FileDTO.FileMetaData fileMetaData;
        private List<ReportFieldDTO.Create> fields;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportUpdateRq")
    public static class Update extends ReportDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
