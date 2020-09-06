package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InvoiceInternalDTO {

    private String id;
    private String bankGroupDesc;
    private String buyerId;
    private String customerCostCenterCode;
    private String customerId;
    private String customerName;
    private Integer hasPollution;
    private Integer hasTax;
    private String invoiceAreaPollution;
    private String invoiceContainerName;
    private Integer invoiceContainerNumber;
    private Double invoiceContainerWeight;
    private String invoiceDate;
    private String invoiceGrossWeight;
    private String invoiceLatinDesc;
    private Double invoiceOtherDeductions;
    private String invoicePersianDesc;
    private Double invoiceRealWeight;
    private String invoiceSalesType;
    private String invoiceSent;
    private String invoiceSerial;
    private Double invoiceTotalTax;
    private String invoiceTotalWeight;
    private Double invoiceUnitPrice;
    private String invoiceValueAdded;
    private String lcCostCenterCode;
    private String lcDueDate;
    private String lcId;
    private String nosaBankCode;
    private String nosaCustomerCode;
    private String nosaCustomerCreditCode;
    private String nosaPollutionCode;
    private String nosaProductCode;
    private String nosaProductGroupCode;
    private String nosaTaxCode;
    private String percentage;
    private Double pollutionChargeAmount;
    private String pollutionCostCenterCode;
    private String productCostCenterCode;
    private String productGroupName;
    private Long productId;
    private String productName;
    private Double realWeight;
    private String remittanceAmount;
    private String remittanceFinalDate;
    private String remittanceId;
    private Integer salesType;
    private Double taxChargeAmount;
    private String taxCostCenterCode;
    private Double TotalAmount;
    private Double totalDeductions;
    private String unitId;
    private Double unitPrice;

    @Getter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalInfo")
    public static class Info extends InvoiceInternalDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalCreateRq")
    public static class Create extends InvoiceInternalDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalUpdateRq")
    public static class Update extends InvoiceInternalDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private String id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<String> ids;
    }

}
