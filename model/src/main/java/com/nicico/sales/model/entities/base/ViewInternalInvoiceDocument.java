package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("SELECT * FROM VIEW_INTERNAL_INVOICE_DOCUMENT")
public class ViewInternalInvoiceDocument {
	@Id
	@Column(name = "ID")
	private String id;

	@Column(name = "C_BANK_GROUP_DESC")
	private String bankGroupDesc;

	@Column(name = "C_BUYER_ID")
	private String buyerId;

	@Column(name = "C_CUSTOMER_COST_CENTER_CODE")
	private String customerCostCenterCode;

	@Column(name = "C_CUSTOMER_ID")
	private String customerId;

	@Column(name = "C_CUSTOMER_NAME")
	private String customerName;

	@Column(name = "N_HAS_POLLUTION")
	private Integer hasPollution;

	@Column(name = "N_HAS_TAX")
	private Integer hasTax;

	@Column(name = "C_INVOICE_AREA_POLLUTION")
	private String invoiceAreaPollution;

	@Column(name = "C_INVOICE_CONTAINER_NAME")
	private String invoiceContainerName;

	@Column(name = "N_INVOICE_CONTAINER_NUMBER")
	private Integer invoiceContainerNumber;

	@Column(name = "N_INVOICE_CONTAINER_WEIGHT", precision = 10)
	private Double invoiceContainerWeight;

	@Column(name = "C_INVOICE_DATE")
	private String invoiceDate;

	@Column(name = "C_INVOICE_GROSS_WEIGHT")
	private String invoiceGrossWeight;

	@Column(name = "C_INVOICE_LATIN_DESC")
	private String invoiceLatinDesc;

	@Column(name = "N_INVOICE_OTHER_DEDUCTIONS", precision = 10)
	private Double invoiceOtherDeductions;

	@Column(name = "C_INVOICE_PERSIAN_DESC")
	private String invoicePersianDesc;

	@Column(name = "N_INVOICE_REAL_WEIGHT", precision = 10)
	private Double invoiceRealWeight;

	@Column(name = "C_INVOICE_SALES_TYPE")
	private String invoiceSalesType;

	@Column(name = "C_INVOICE_SENT")
	private String invoiceSent;

	@Column(name = "C_INVOICE_SERIAL")
	private String invoiceSerial;

	@Column(name = "N_INVOICE_TOTAL_TAX", precision = 10)
	private Double invoiceTotalTax;

	@Column(name = "C_INVOICE_TOTAL_WEIGHT")
	private String invoiceTotalWeight;

	@Column(name = "N_INVOICE_UNIT_PRICE", precision = 10)
	private Double invoiceUnitPrice;

	@Column(name = "C_INVOICE_VALUE_ADDED")
	private String invoiceValueAdded;

	@Column(name = "C_LC_COST_CENTER_CODE")
	private String lcCostCenterCode;

	@Column(name = "C_LC_DUE_DATE")
	private String lcDueDate;

	@Column(name = "C_LC_ID")
	private String lcId;

	@Column(name = "C_NOSA_BANK_CODE")
	private String nosaBankCode;

	@Column(name = "C_NOSA_CUSTOMER_CODE")
	private String nosaCustomerCode;

	@Column(name = "C_NOSA_CUSTOMER_CREDIT_CODE")
	private String nosaCustomerCreditCode;

	@Column(name = "C_NOSA_POLLUTION_CODE")
	private String nosaPollutionCode;

	@Column(name = "C_NOSA_PRODUCT_CODE")
	private String nosaProductCode;

	@Column(name = "C_NOSA_PRODUCT_GROUP_CODE")
	private String nosaProductGroupCode;

	@Column(name = "C_NOSA_TAX_CODE")
	private String nosaTaxCode;

	@Column(name = "C_PERCENTAGE")
	private String percentage;

	@Column(name = "N_POLLUTION_CHARGE_AMOUNT", precision = 10)
	private Double pollutionChargeAmount;

	@Column(name = "C_POLLUTION_COST_CENTER_CODE")
	private String pollutionCostCenterCode;

	@Column(name = "C_PRODUCT_COST_CENTER_CODE")
	private String productCostCenterCode;

	@Column(name = "C_PRODUCT_GROUP_NAME")
	private String productGroupName;

	@Column(name = "N_PRODUCT_ID")
	private Long productId;

	@Column(name = "C_PRODUCT_NAME")
	private String productName;

	@Column(name = "N_REAL_WEIGHT", precision = 10)
	private Double realWeight;

	@Column(name = "C_REMITTANCE_AMOUNT")
	private String remittanceAmount;

	@Column(name = "C_REMITTANCE_FINAL_DATE")
	private String remittanceFinalDate;

	@Column(name = "C_REMITTANCE_ID")
	private String remittanceId;

	@Column(name = "N_SALES_TYPE")
	private Integer salesType;

	@Column(name = "N_TAX_CHARGE_AMOUNT", precision = 10)
	private Double taxChargeAmount;

	@Column(name = "C_TAX_COST_CENTER_CODE")
	private String taxCostCenterCode;

	@Column(name = "N_TOTAL_AMOUNT", precision = 10)
	private Double totalAmount;

	@Column(name = "N_TOTAL_DEDUCTIONS", precision = 10)
	private Double totalDeductions;

	@Column(name = "C_UNIT_ID")
	private String unitId;

	@Column(name = "N_UNIT_PRICE", precision = 10)
	private Double unitPrice;

	@Column(name = "C_DOCUMENT_ID")
	private String documentId;
}
