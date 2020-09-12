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
                "LCID AS ID, " +
                "BANKGROUPDESC AS C_BANK_GROUP_DESC, " +
                "BANKGROUPID AS C_BANK_GROUP_ID, " +
                "STATEINOUT AS C_IN_OUT_STATE, " +
                "LC_MEGHDAR AS N_LC_َAMOUNT, " +
                "LC_BANKLC AS C_LC_BANK, " +
                "LC_CODEMARKAZHAZINEHLC AS C_LC_COST_CENTER_CODE, " +
                "LC_CUSTOMERID AS C_LC_CUSTOMER_ID, " +
                "LC_CUSTOMERNAME AS C_LC_CUSTOMER_NAME, " +
                "LC_DATESARRESED AS C_LC_DUE_DATE, " +
                "LC_PICTURE AS C_LC_IMAGE, " +
                "LC_DATESEDOR AS C_LC_ISSUE_DATE, " +
                "LC_MARK AS C_LC_MARK, " +
                "LC_NUMBER AS C_LC_NUMBER, " +
                "LC_PREFACTOR AS C_LC_PREINVOICE, " +
                "LC_PRICE AS N_LC_PRICE, " +
                "LC_GOODSID AS N_LC_PRODUCT_ID, " +
                "LC_GOODSNAME AS C_LC_PRODUCT_NAME, " +
                "LC_STATE AS N_LC_STATE, " +
                "LCSTATEDESC AS C_LC_STATE_DESC, " +
                "LC_BANKLCMOAMELEH AS C_LC_TRANSACTION_BANK, " +
                "BANKLCMOAMELEHDESCSHOBEH AS C_LC_TRANSACTION_BANK_BRANCH, " +
                "LC_TYPE AS N_LC_TYPE, " +
                "LCTYPEDESC AS C_LC_TYPE_DESC, " +
                "LC_USER AS C_LC_USER, " +
                "PREFACTOR_CUSTOMERNAME AS C_PREINVOICE_CUSTOMER_NAME, " +
                "PREFACTOR_KALANAME AS C_PREINVOICE_PRODUCT_SET, " +
                "BANKLCDESCSHOBEH AS C_TRANSACTION_BANK_BRANCH, " +
                "USERNAME AS C_USERNAME " +
                "FROM " +
                "LC_T LC"
)
public class ViewLC {
    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "C_BANK_GROUP_DESC")
    private String bankGroupDesc;

    @Column(name = "C_BANK_GROUP_ID")
    private String bankGroupId;

    @Column(name = "C_IN_OUT_STATE")
    private String inOutState;

    @Column(name = "N_LC_AMOUNT")
    private Long lcَAmount;

    @Column(name = "C_LC_BANK")
    private String lcBank;

    @Column(name = "C_LC_COST_CENTER_CODE")
    private String lcCostCenterCode;

    @Column(name = "C_LC_CUSTOMER_ID")
    private String lcCustomerId;

    @Column(name = "C_LC_CUSTOMER_NAME")
    private String lcCustomerName;

    @Column(name = "C_LC_DUE_DATE")
    private String lcDueDate;

    @Column(name = "C_LC_IMAGE")
    private String lcImage;

    @Column(name = "C_LC_ISSUE_DATE")
    private String lcIssueDate;

    @Column(name = "C_LC_MARK")
    private String lcMark;

    @Column(name = "C_LC_NUMBER")
    private String lcNumber;

    @Column(name = "C_LC_PREINVOICE")
    private String lcPreInvoice;

    @Column(name = "N_LC_PRICE")
    private Long lcPrice;

    @Column(name = "N_LC_PRODUCT_ID")
    private Long lcProductId;

    @Column(name = "C_LC_PRODUCT_NAME")
    private String lcProductName;

    @Column(name = "N_LC_STATE")
    private Integer lcState;

    @Column(name = "C_LC_STATE_DESC")
    private String lcStateDesc;

    @Column(name = "C_LC_TRANSACTION_BANK")
    private String lcTransactionBank;

    @Column(name = "C_LC_TRANSACTION_BANK_BRANCH")
    private String lcTransactionBankBranch;

    @Column(name = "N_LC_TYPE")
    private Integer lcType;

    @Column(name = "C_LC_TYPE_DESC")
    private String lcTypeDesc;

    @Column(name = "C_LC_USER")
    private String lcUser;

    @Column(name = "C_PREINVOICE_CUSTOMER_NAME")
    private String preInvoiceCustomerName;

    @Column(name = "C_PREINVOICE_PRODUCT_SET")
    private String preInvoiceProductSet;

    @Column(name = "C_TRANSACTION_BANK_BRANCH")
    private String transactionBankBranch;

    @Column(name = "C_USERNAME")
    private String username;
}
