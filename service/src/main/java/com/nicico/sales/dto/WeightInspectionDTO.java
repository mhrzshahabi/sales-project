package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.model.enumeration.WeighingType;
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
public abstract class WeightInspectionDTO {

    private WeighingType weighingType;
    private BigDecimal weightGW;
    private BigDecimal weightND;
    private Long unitId;
    private Long shipmentId;
    private Long inventoryId;
    private Long inspectionReportId;
    private InspectionReportMilestone mileStone;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WeightInspectionInfoWithoutInspectionReport")
    public static class InfoWithoutInspectionReportAndInventory extends WeightInspectionDTO {

        private Long id;
        private UnitDTO.Info unit;

        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;

        public BigDecimal getWeightDiff() {

            BigDecimal weightGW = getWeightGW();
            BigDecimal weightND = getWeightND();
            if (weightGW == null) weightGW = BigDecimal.ZERO;
            if (weightND == null) weightND = BigDecimal.ZERO;

            return weightGW.subtract(weightND);
        }
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WeightInspectionInfoWithoutInspectionReport")
    public static class InfoWithoutInspectionReport extends InfoWithoutInspectionReportAndInventory {

        private InventoryDTO.Info inventory;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WeightInspectionInfo")
    public static class Info extends InfoWithoutInspectionReport {

        private InspectionReportDTO.Info inspectionReport;
        private ShipmentDTO.Info shipment;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WeightInspectionCreateRq")
    public static class Create extends WeightInspectionDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WeightInspectionUpdateRq")
    public static class Update extends WeightInspectionDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WeightInspectionDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
