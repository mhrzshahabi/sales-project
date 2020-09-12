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
public class ViewInternalInvoice {
    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "C_BANKGROUPDESC")
    private String bankGroupDesc;

    @Column(name = "C_BUYERID")
    private String buyerId;

    @Column(name = "C_CUSTOMERCOSTCENTERCODE")
    private String customerCostCenterCode;

    @Column(name = "C_CUSTOMERID")
    private String customerId;

    @Column(name = "C_CUSTOMERNAME")
    private String customerName;

    @Column(name = "N_HASPOLLUTION")
    private Integer hasPollution;

    @Column(name = "N_HASTAX")
    private Integer hasTax;

    @Column(name = "C_INVOICEAREAPOLLUTION")
    private String invoiceAreaPollution;

    @Column(name = "C_INVOICECONTAINERNAME")
    private String invoiceContainerName;

    @Column(name = "C_INVOICECONTAINERNUMBER")
    private Integer invoiceContainerNumber;

    @Column(name = "N_INVOICECONTAINERWEIGHT", precision = 10)
    private Double invoiceContainerWeight;

    @Column(name = "C_INVOICEDATE")
    private String invoiceDate;

    @Column(name = "C_INVOICEGROSSWEIGHT")
    private String invoiceGrossWeight;

    @Column(name = "C_INVOICELATINDESC")
    private String invoiceLatinDesc;

    @Column(name = "N_INVOICEOTHERDEDUCTIONS", precision = 10)
    private Double invoiceOtherDeductions;

    @Column(name = "C_INVOICEPERSIANDESC")
    private String invoicePersianDesc;

    @Column(name = "N_INVOICEREALWEIGHT", precision = 10)
    private Double invoiceRealWeight;

    @Column(name = "C_INVOICESALESTYPE")
    private String invoiceSalesType;

    @Column(name = "C_INVOICESENT")
    private String invoiceSent;

    @Column(name = "C_INVOICESERIAL")
    private String invoiceSerial;

    @Column(name = "N_INVOICETOTALTAX", precision = 10)
    private Double invoiceTotalTax;

    @Column(name = "C_INVOICETOTALWEIGHT")
    private String invoiceTotalWeight;

    @Column(name = "N_INVOICEUNITPRICE", precision = 10)
    private Double invoiceUnitPrice;

    @Column(name = "C_INVOICEVALUEADDED")
    private String invoiceValueAdded;

    @Column(name = "C_LCCOSTCENTERCODE")
    private String lcCostCenterCode;

    @Column(name = "C_LCDUEDATE")
    private String lcDueDate;

    @Column(name = "C_LCID")
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
