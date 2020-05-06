package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
public class CostDTO {

    private Long shipmentId;
    private Long sourceInspectorId;
    private Double sourceInspectionCost;
    private String sourceInspectionCurrency;
    private Long destinationInspectorId;
    private Double destinationInspectionCost;
    private String destinationInspectionCurrency;
    private Double certificateOriginCost;
    private Double beforePaid;
    private String certificateOriginCostCurrency;
    private Double sarcheshmehLabCost;
    private String sarcheshmehLabCostCurrency;
    private Double umpireCost;
    private String umpireCostCurrency;
    private Double shippingCostsBetweenAssemblies;
    private String shippingCostsCurrencyBetweenAssemblies;
    private Double sourceGold;
    private Double sourceSilver;
    private Double sourceCopper;
    private Double sourceMolybdenum;
    private Double destinationGold;
    private Double destinationSilver;
    private Double destinationCopper;
    private Double destinationMolybdenum;
    private Long insuranceId;
    private Double insuranceCost;
    private String insuranceCostCurrency;
    private String insuranceClause;
    private Long inventortRentCost;
    private Double postCost;
    private String postCostCurrency;
    private Double thcCost;
    private Double blFeeCost;
    private Double demandCost;
    private String demandCurrency;
    private Double contractorCost;
    private String contractorCostCurrency;
    private Double counterCost;
    private Double disinfectionCost;
    private Double portCost;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CostInfo")
    public static class Info extends CostDTO {
        private ShipmentDTO Shipment;
        private ContactDTO.ContactInfoTuple sourceInspector;
        private ContactDTO.ContactInfoTuple destinationInspector;
        private ContactDTO.ContactInfoTuple insurance;
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CostCreateRq")
    public static class Create extends CostDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CostUpdateRq")
    public static class Update extends CostDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CostDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
