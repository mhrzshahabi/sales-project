package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
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
public class ShipmentCostInvoiceDTO {

    private Long referenceId;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date invoiceDate;
    private String invoiceNoPaper;
    private String invoiceNo;
    private BigDecimal tVat;
    private BigDecimal cVat;
    private BigDecimal sumPrice;
    private BigDecimal sumPriceWithDiscount;
    private BigDecimal sumPriceWithVat;
    private BigDecimal rialPrice;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date conversionDate;
    private BigDecimal conversionRate;
    private BigDecimal conversionSumPrice;
    private String conversionSumPriceText;
    private Double buyerShare;
    private BigDecimal conversionSumPriceBuyerShare;
    private BigDecimal conversionSumPriceSellerShare;
    private String description;
    private Long invoiceTypeId;
    private Long conversionRefId;
    private Long sellerContactId;
    private Long buyerContactId;
    private Long financeUnitId;
    private Long contractId;
    private List<ShipmentCostInvoiceDetailDTO.Info> shipmentCostInvoiceDetails;



    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCostInvoiceInfo")
    public static class Info extends ShipmentCostInvoiceDTO {

        private Long id;
        private InvoiceTypeDTO.Info invoiceType;
        private CurrencyRateDTO.Info conversionRef;
        private ContactDTO.Info sellerContact;
        private ContactDTO.Info buyerContact;
        private UnitDTO.Info financeUnit;
        private ContractDTO.Info contract;


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
    @ApiModel("ShipmentCostInvoiceCreateRq")
    public static class Create extends ShipmentCostInvoiceDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCostInvoiceUpdateRq")
    public static class Update extends ShipmentCostInvoiceDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCostInvoiceDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
