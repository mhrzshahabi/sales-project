package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AssayInspectionTotalValuesDTO {

    private BigDecimal value;
    private Long materialElementId;
    private Long inspectionReportId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionTotalValuesInfo")
    public static class Info extends AssayInspectionTotalValuesDTO {

        private Long id;
        private MaterialElementDTO.Info materialElement;

        // Auditing
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
    @ApiModel("AssayInspectionTotalValuesCreateRq")
    public static class Create extends AssayInspectionTotalValuesDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionTotalValuesUpdateRq")
    public static class Update extends AssayInspectionTotalValuesDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionTotalValuesDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
