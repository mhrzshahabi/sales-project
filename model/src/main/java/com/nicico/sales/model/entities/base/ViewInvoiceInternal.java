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
                "BANKGROUPDESC AS BANKGROUPDESC, " +
                "BUYERID AS BUYERID, " +
                "CODEMARKAZHAZINEHCUSTOMER AS CUSTOMERCOSTCENTERCODE, " +
                "CUSTOMERID AS CUSTOMERID, " +
                "CUST_NAME AS CUSTOMERNAME, " +
                "HAVEALAYANDEGI AS HASPOLLUTION, " +
                "HAVEMALEYATE AS HASTAX, " +
                "INV_AREAALANDEGI AS INVOICEAREAPOLLUTION, " +
                "INV_CONTAINER_NAME AS INVOICECONTAINERNAME, " +
                "INV_CONTAINER_NUMBER AS INVOICECONTAINERNUMBER, " +
                "INV_CONTAINER_WEIGHT AS INVOICECONTAINERWEIGHT, " +
                "INV_DATE AS INVOICEDATE, " +
                "INV_NONPOUR_WEIGHT AS INVOICEGROSSWEIGHT, " +
                "INV_LATINDESC AS INVOICELATINDESC, " +
                "INV_OTHER_KOSORAT AS INVOICEOTHERDEDUCTIONS, " +
                "INV_PERSIANDESC AS INVOICEPERSIANDESC, " +
                "INV_REAL_WEIGHT AS INVOICEREALWEIGHT, " +
                "INV_SALETYPE AS INVOICESALESTYPE, " +
                "INV_SENTED AS INVOICESENT, " +
                "SHOMAREHSORATHESAB AS INVOICESERIAL, " +
                "INV_TOTAL_KOSORAT_AVAREZ AS INVOICETOTALTAX, " +
                "INV_ALLWEIGHT AS INVOICETOTALWEIGHT, " +
                "INV_UNITCOST AS INVOICEUNITPRICE, " +
                "INV_AREAAFZODEH AS INVOICEVALUEADDED, " +
                "CODEMARKAZHAZINEHLC AS LCCOSTCENTERCODE, " +
                "LC_DATESARRESED AS LCDUEDATE, " +
                "LCID AS LCID, " +
                "CODENOSABANK AS NOSABANKCODE, " +
                "CODENOSACUSTOMER AS NOSACUSTOMERCODE, " +
                "CODEETEBARENOSACUSTOMER AS NOSACUSTOMERCREDITCODE, " +
                "CODENOSAALAYANDEGI AS NOSAPOLLUTIONCODE, " +
                "CODENOSAMAHSOL AS NOSAPRODUCTCODE, " +
                "GRUPGOODSNOSA AS NOSAPRODUCTGROUPCODE, " +
                "CODENOSAMALYATE AS NOSATAXCODE, " +
                "PERSENT AS PERCENTAGE, " +
                "PAYFORAVAREZALAYANDEGH AS POLLUTIONCHARGEAMOUNT, " +
                "MARKAZHAZINEHALAYANDEGI AS POLLUTIONCOSTCENTERCODE, " +
                "CODEMARKAZHAZINEHMAHSOL AS PRODUCTCOSTCENTERCODE, " +
                "GRUPGOODNAME AS PRODUCTGROUPNAME, " +
                "GOODSID AS PRODUCTID, " +
                "GDSNAME AS PRODUCTNAME, " +
                "WEIGHTREAL AS REALWEIGHT, " +
                "HAV_MEGHDAR AS REMITTANCEAMOUNT, " +
                "HAV_FINALDATE AS REMITTANCEFINALDATE, " +
                "HAVALEHID AS REMITTANCEID, " +
                "TYPEFROSH AS SALESTYPE, " +
                "PAYFORAVAREZMALEYATE AS TAXCHARGEAMOUNT, " +
                "MARKAZHAZINEHMALYATE AS TAXCOSTCENTERCODE, " +
                "MABLAGHKOL AS TOTALAMOUNT, " +
                "TOTALKOSORAT AS TOTALDEDUCTIONS, " +
                "UNITID AS UNITID, " +
                "GHEMATUNIT AS UNITPRICE " +
                "FROM " +
                "VIEW_INNERSALESFORSALSE VI " +
                "WHERE VI.INV_ID NOT IN (SELECT TI.INV_ID FROM TBL_INVOICEINTERNALDOCUMENT TI)"
)
public class ViewInvoiceInternal {
    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "BANKGROUPDESC")
    private String bankGroupDesc;

    @Column(name = "BUYERID")
    private String buyerId;

    @Column(name = "CUSTOMERCOSTCENTERCODE")
    private String customerCostCenterCode;

    @Column(name = "CUSTOMERID")
    private String customerId;

    @Column(name = "CUSTOMERNAME")
    private String customerName;

    @Column(name = "HASPOLLUTION")
    private Integer hasPollution;

    @Column(name = "HASTAX")
    private Integer hasTax;

    @Column(name = "INVOICEAREAPOLLUTION")
    private String invoiceAreaPollution;

    @Column(name = "INVOICECONTAINERNAME")
    private String invoiceContainerName;

    @Column(name = "INVOICECONTAINERNUMBER")
    private Integer invoiceContainerNumber;

    @Column(name = "INVOICECONTAINERWEIGHT", precision = 10)
    private Double invoiceContainerWeight;

    @Column(name = "INVOICEDATE")
    private String invoiceDate;

    @Column(name = "INVOICEGROSSWEIGHT")
    private String invoiceGrossWeight;

    @Column(name = "INVOICELATINDESC")
    private String invoiceLatinDesc;

    @Column(name = "INVOICEOTHERDEDUCTIONS", precision = 10)
    private Double invoiceOtherDeductions;

    @Column(name = "INVOICEPERSIANDESC")
    private String invoicePersianDesc;

    @Column(name = "INVOICEREALWEIGHT", precision = 10)
    private Double invoiceRealWeight;

    @Column(name = "INVOICESALESTYPE")
    private String invoiceSalesType;

    @Column(name = "INVOICESENT")
    private String invoiceSent;

    @Column(name = "INVOICESERIAL")
    private String invoiceSerial;

    @Column(name = "INVOICETOTALTAX", precision = 10)
    private Double invoiceTotalTax;

    @Column(name = "INVOICETOTALWEIGHT")
    private String invoiceTotalWeight;

    @Column(name = "INVOICEUNITPRICE", precision = 10)
    private Double invoiceUnitPrice;

    @Column(name = "INVOICEVALUEADDED")
    private String invoiceValueAdded;

    @Column(name = "LCCOSTCENTERCODE")
    private String lcCostCenterCode;

    @Column(name = "LCDUEDATE")
    private String lcDueDate;

    @Column(name = "LCID")
    private String lcId;

    @Column(name = "NOSABANKCODE")
    private String nosaBankCode;

    @Column(name = "NOSACUSTOMERCODE")
    private String nosaCustomerCode;

    @Column(name = "NOSACUSTOMERCREDITCODE")
    private String nosaCustomerCreditCode;

    @Column(name = "NOSAPOLLUTIONCODE")
    private String nosaPollutionCode;

    @Column(name = "NOSAPRODUCTCODE")
    private String nosaProductCode;

    @Column(name = "NOSAPRODUCTGROUPCODE")
    private String nosaProductGroupCode;

    @Column(name = "NOSATAXCODE")
    private String nosaTaxCode;

    @Column(name = "PERCENTAGE")
    private String percentage;

    @Column(name = "POLLUTIONCHARGEAMOUNT", precision = 10)
    private Double pollutionChargeAmount;

    @Column(name = "POLLUTIONCOSTCENTERCODE")
    private String pollutionCostCenterCode;

    @Column(name = "PRODUCTCOSTCENTERCODE")
    private String productCostCenterCode;

    @Column(name = "PRODUCTGROUPNAME")
    private String productGroupName;

    @Column(name = "PRODUCTID")
    private Long productId;

    @Column(name = "PRODUCTNAME")
    private String productName;

    @Column(name = "REALWEIGHT", precision = 10)
    private Double realWeight;

    @Column(name = "REMITTANCEAMOUNT")
    private String remittanceAmount;

    @Column(name = "REMITTANCEFINALDATE")
    private String remittanceFinalDate;

    @Column(name = "REMITTANCEID")
    private String remittanceId;

    @Column(name = "SALESTYPE")
    private Integer salesType;

    @Column(name = "TAXCHARGEAMOUNT", precision = 10)
    private Double taxChargeAmount;

    @Column(name = "TAXCOSTCENTERCODE")
    private String taxCostCenterCode;

    @Column(name = "TOTALAMOUNT", precision = 10)
    private Double totalAmount;

    @Column(name = "TOTALDEDUCTIONS", precision = 10)
    private Double totalDeductions;

    @Column(name = "UNITID")
    private String unitId;

    @Column(name = "UNITPRICE", precision = 10)
    private Double unitPrice;
}
