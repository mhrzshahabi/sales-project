package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InternalInvoiceDTO {

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
    private String documentId;
    private List<EStatus> eStatus;

	@Getter
	@Accessors(chain = true)
	@ApiModel("InvoiceInternalInfo")
	public static class Info extends InternalInvoiceDTO {
	}

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalCreateRq")
    public static class Create extends InternalInvoiceDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalUpdateRq")
    public static class Update extends InternalInvoiceDTO {
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalDeleteRq")
    public static class Delete {
    }

}
