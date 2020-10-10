package com.nicico.sales.dto.report;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.report.Report;
import com.nicico.sales.model.entities.report.ReportGroup;
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
public class ReportGroupDTO {

    private Long id;
    private String nameFA;
    private String nameEN;
    private String name;
    private String order;
    private Long parentId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportGroupInfo")
    public static class Info extends ReportGroupDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        private ReportGroup parent;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportGroupCreateRq")
    public static class Create extends ReportGroupDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportGroupUpdateRq")
    public static class Update extends ReportGroupDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ReportGroupDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
