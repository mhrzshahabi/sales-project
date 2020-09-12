package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect(
        "SELECT " +
                "INV_ID AS ID, " +
                "BANKGROUPDESC AS C_BANK_GROUP_DESC, " +
                "BUYERID AS C_BUYER_ID, " +
                "CODEMARKAZHAZINEHCUSTOMER AS C_CUSTOMER_COST_CENTER_CODE, " +
                "CUSTOMERID AS C_CUSTOMER_ID, " +
                "CUST_NAME AS C_CUSTOMER_NAME, " +
                "HAVEALAYANDEGI AS N_HAS_POLLUTION, " +
                "HAVEMALEYATE AS N_HAS_TAX, " +
                "INV_AREAALANDEGI AS C_INVOICE_AREA_POLLUTION, " +
                "INV_CONTAINER_NAME AS C_INVOICE_CONTAINER_NAME, " +
                "INV_CONTAINER_NUMBER AS N_INVOICE_CONTAINER_NUMBER, " +
                "INV_CONTAINER_WEIGHT AS N_INVOICE_CONTAINER_WEIGHT, " +
                "INV_DATE AS C_INVOICE_DATE, " +
                "INV_NONPOUR_WEIGHT AS C_INVOICE_GROSS_WEIGHT, " +
                "INV_LATINDESC AS C_INVOICE_LATIN_DESC, " +
                "INV_OTHER_KOSORAT AS N_INVOICE_OTHER_DEDUCTIONS, " +
                "INV_PERSIANDESC AS C_INVOICE_PERSIAN_DESC, " +
                "INV_REAL_WEIGHT AS N_INVOICE_REAL_WEIGHT, " +
                "INV_SALETYPE AS C_INVOICE_SALES_TYPE, " +
                "INV_SENTED AS C_INVOICE_SENT, " +
                "SHOMAREHSORATHESAB AS C_INVOICE_SERIAL, " +
                "INV_TOTAL_KOSORAT_AVAREZ AS N_INVOICE_TOTAL_TAX, " +
                "INV_ALLWEIGHT AS C_INVOICE_TOTAL_WEIGHT, " +
                "INV_UNITCOST AS N_INVOICE_UNIT_PRICE, " +
                "INV_AREAAFZODEH AS C_INVOICE_VALUE_ADDED, " +
                "CODEMARKAZHAZINEHLC AS C_LC_COST_CENTER_CODE, " +
                "LC_DATESARRESED AS C_LC_DUE_DATE, " +
                "LCID AS C_LC_ID, " +
                "CODENOSABANK AS C_NOSA_BANK_CODE, " +
                "CODENOSACUSTOMER AS C_NOSA_CUSTOMER_CODE, " +
                "CODEETEBARENOSACUSTOMER AS C_NOSA_CUSTOMER_CREDIT_CODE, " +
                "CODENOSAALAYANDEGI AS C_NOSA_POLLUTION_CODE, " +
                "CODENOSAMAHSOL AS C_NOSA_PRODUCT_CODE, " +
                "GRUPGOODSNOSA AS C_NOSA_PRODUCT_GROUP_CODE, " +
                "CODENOSAMALYATE AS C_NOSA_TAX_CODE, " +
                "PERSENT AS C_PERCENTAGE, " +
                "PAYFORAVAREZALAYANDEGH AS N_POLLUTION_CHARGE_AMOUNT, " +
                "MARKAZHAZINEHALAYANDEGI AS C_POLLUTION_COST_CENTER_CODE, " +
                "CODEMARKAZHAZINEHMAHSOL AS C_PRODUCT_COST_CENTER_CODE, " +
                "GRUPGOODNAME AS C_PRODUCT_GROUP_NAME, " +
                "GOODSID AS N_PRODUCT_ID, " +
                "GDSNAME AS C_PRODUCT_NAME, " +
                "WEIGHTREAL AS N_REAL_WEIGHT, " +
                "HAV_MEGHDAR AS C_REMITTANCE_AMOUNT, " +
                "HAV_FINALDATE AS C_REMITTANCE_FINAL_DATE, " +
                "HAVALEHID AS C_REMITTANCE_ID, " +
                "TYPEFROSH AS N_SALES_TYPE, " +
                "PAYFORAVAREZMALEYATE AS N_TAX_CHARGE_AMOUNT, " +
                "MARKAZHAZINEHMALYATE AS C_TAX_COST_CENTER_CODE, " +
                "MABLAGHKOL AS N_TOTAL_AMOUNT, " +
                "TOTALKOSORAT AS N_TOTAL_DEDUCTIONS, " +
                "UNITID AS C_UNIT_ID, " +
                "GHEMATUNIT AS N_UNIT_PRICE " +
                "FROM " +
                "VIEW_INNERSALESFORSALSE VI " +
                "WHERE VI.INV_ID NOT IN (SELECT TI.INV_ID FROM TBL_INVOICEINTERNALDOCUMENT TI)"
)
public class ViewInternalInvoice {
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
}
