package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.ShipmentCostDuty;
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
public class ShipmentCostInvoiceDetailDTO {

    private String serviceCode;
    private String serviceName;
    private BigDecimal quantity;
    private BigDecimal unitPrice;
    private BigDecimal sumPrice;
    private BigDecimal discountPrice;
    private BigDecimal sumPriceWithDiscount;
    private BigDecimal tVatPrice;
    private BigDecimal cVatPrice;
    private BigDecimal sumVatPrice;
    private BigDecimal sumPriceWithVat;
    private Long shipmentCostInvoiceId;
    private Long shipmentCostDutyId;
    private Long unitID;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCostInvoiceDetailInfo")
    public static class Info extends ShipmentCostInvoiceDetailDTO {

        private Long id;

        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
        private ShipmentCostDutyDTO.Info  shipmentCostDuty;
        private UnitDTO.Info  unit;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCostInvoiceDetailCreateRq")
    public static class Create extends ShipmentCostInvoiceDetailDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCostInvoiceDetailUpdateRq")
    public static class Update extends ShipmentCostInvoiceDetailDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCostInvoiceDetailDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
