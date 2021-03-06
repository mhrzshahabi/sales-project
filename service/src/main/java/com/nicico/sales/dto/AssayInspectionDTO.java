package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
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
    private String labName;
    private String labPlace;
    private Long shipmentId;
    private Long inventoryId;
    private Long materialElementId;
    private Long inspectionReportId;
    private InspectionReportMilestone mileStone;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionInfoWithoutInspectionReportAndInventory")
    public static class InfoWithoutInspectionReportAndInventory extends AssayInspectionDTO {

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
    @ApiModel("AssayInspectionInfoWithoutInspectionReport")
    public static class InfoWithoutInspectionReport extends InfoWithoutInspectionReportAndInventory {

        private InventoryDTO.Info inventory;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AssayInspectionInfo")
    public static class Info extends InfoWithoutInspectionReport {

        private InspectionReportDTO.Info inspectionReport;
        private ShipmentDTO.Info shipment;
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

        private Integer version;
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
