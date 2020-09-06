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
        "SELECT" +
                "LCID AS ID, " +
                "BANKGROUPDESC AS BANKGROUPDESC, " +
                "BANKGROUPID AS BANKGROUPID, " +
                "STATEINOUT AS INOUTSTATE, " +
                "LC_MEGHDAR AS LCَAMOUNT, " +
                "LC_BANKLC AS LCBANK, " +
                "LC_CODEMARKAZHAZINEHLC AS LCCOSTCENTERCODE, " +
                "LC_CUSTOMERID AS LCCUSTOMERID, " +
                "LC_CUSTOMERNAME AS LCCUSTOMERNAME, " +
                "LC_DATESARRESED AS LCDUEDATE, " +
                "LC_PICTURE AS LCIMAGE, " +
                "LC_DATESEDOR AS LCISSUEDATE, " +
                "LC_MARK AS LCMARK, " +
                "LC_NUMBER AS LCNUMBER, " +
                "LC_PREFACTOR AS LCPREINVOICE, " +
                "LC_PRICE AS LCPRICE, " +
                "LC_GOODSID AS LCPRODUCTID, " +
                "LC_GOODSNAME AS LCPRODUCTNAME, " +
                "LC_STATE AS LCSTATE, " +
                "LCSTATEDESC AS LCSTATEDESC, " +
                "LC_BANKLCMOAMELEH AS LCTRANSACTIONBANK, " +
                "BANKLCMOAMELEHDESCSHOBEH AS LCTRANSACTIONBANKBRANCH, " +
                "LC_TYPE AS LCTYPE, " +
                "LCTYPEDESC AS LCTYPEDESC, " +
                "LC_USER AS LCUSER, " +
                "PREFACTOR_CUSTOMERNAME AS PREINVOICECUSTOMERNAME, " +
                "PREFACTOR_KALANAME AS PREINVOICEPRODUCTSET, " +
                "BANKLCDESCSHOBEH AS TRANSACTIONBANKBRANCH, " +
                "USERNAME AS USERNAME " +
                "FROM " +
                "LC_T LC"
)
public class ViewLC {
    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "BANKGROUPDESC")
    private String bankGroupDesc;

    @Column(name = "BANKGROUPID")
    private String bankGroupId;

    @Column(name = "INOUTSTATE")
    private String inOutState;

    @Column(name = "LCَAMOUNT")
    private Long lcَAmount;

    @Column(name = "LCBANK")
    private String lcBank;

    @Column(name = "LCCOSTCENTERCODE")
    private String lcCostCenterCode;

    @Column(name = "LCCUSTOMERID")
    private String lcCustomerId;

    @Column(name = "LCCUSTOMERNAME")
    private String lcCustomerName;

    @Column(name = "LCDUEDATE")
    private String lcDueDate;

    @Column(name = "LCIMAGE")
    private String lcImage;

    @Column(name = "LCISSUEDATE")
    private String lcIssueDate;

    @Column(name = "LCMARK")
    private String lcMark;

    @Column(name = "LCNUMBER")
    private String lcNumber;

    @Column(name = "LCPREINVOICE")
    private String lcPreInvoice;

    @Column(name = "LCPRICE")
    private Long lcPrice;

    @Column(name = "LCPRODUCTID")
    private Long lcProductId;

    @Column(name = "LCPRODUCTNAME")
    private String lcProductName;

    @Column(name = "LCSTATE")
    private Integer lcState;

    @Column(name = "LCSTATEDESC")
    private String lcStateDesc;

    @Column(name = "LCTRANSACTIONBANK")
    private String lcTransactionBank;

    @Column(name = "LCTRANSACTIONBANKBRANCH")
    private String lcTransactionBankBranch;

    @Column(name = "LCTYPE")
    private Integer lcType;

    @Column(name = "LCTYPEDESC")
    private String lcTypeDesc;

    @Column(name = "LCUSER")
    private String lcUser;

    @Column(name = "PREINVOICECUSTOMERNAME")
    private String preInvoiceCustomerName;

    @Column(name = "PREINVOICEPRODUCTSET")
    private String preInvoiceProductSet;

    @Column(name = "TRANSACTIONBANKBRANCH")
    private String transactionBankBranch;

    @Column(name = "USERNAME")
    private String username;
}
