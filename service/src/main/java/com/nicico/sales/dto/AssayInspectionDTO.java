package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
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
public class AssayInspectionDTO {

    private BigDecimal value;
    private Long inspectionReportId;
    private Long remittanceDetailId;
    private Long materialElementId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionInfo")
    public static class Info extends AssayInspectionDTO {

        private Long id;
        private InspectionReportDTO.Info inspectionReport;
        private RemittanceDetailDTO.Info remittanceDetail;
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
    @ApiModel("AssayInspectionCreateRq")
    public static class Create extends AssayInspectionDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionUpdateRq")
    public static class Update extends AssayInspectionDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
