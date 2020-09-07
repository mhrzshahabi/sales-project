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
                "CUST_ID AS ID, " +
                "CUST_ADDRESS AS CUSTOMERADDRESS, " +
                "CUST_CODEMARKAZHAZ AS CUSTOMERCOSTCENTERCODE, " +
                "CUST_SHARH AS CUSTOMERDESC, " +
                "CUST_EGHTESADNUMBER AS CUSTOMERECONOMICALNUMBER, " +
                "CUST_FAX AS CUSTOMERFAX, " +
                "CUST_NAME AS CUSTOMERNAME, " +
                "CUST_CODENOSA AS CUSTOMERNOSACODE, " +
                "CUST_CODEETEBARENOSA AS CUSTOMERNOSACREDITCODE, " +
                "CUST_POSTCODE AS CUSTOMERPOSTALCODE, " +
                "CUST_SABTNUMBER AS CUSTOMERREGISTERNUMBER, " +
                "CUST_TEL AS CUSTOMERTEL, " +
                "CUST_TELEX AS CUSTOMERTELEX " +
                "FROM " +
                "CUSTOMER1TBL C"
)
public class ViewCustomer {
    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "CUSTOMERADDRESS")
    private String customerAddress;

    @Column(name = "CUSTOMERCOSTCENTERCODE")
    private String customerCostCenterCode;

    @Column(name = "CUSTOMERDESC")
    private String customerDesc;

    @Column(name = "CUSTOMERECONOMICALNUMBER")
    private String customerEconomicalNumber;

    @Column(name = "CUSTOMERFAX")
    private String customerFax;

    @Column(name = "CUSTOMERNAME")
    private String customerName;

    @Column(name = "CUSTOMERNOSACODE")
    private String customerNosaCode;

    @Column(name = "CUSTOMERNOSACREDITCODE")
    private String customerNosaCreditCode;

    @Column(name = "CUSTOMERPOSTALCODE")
    private String customerPostalCode;

    @Column(name = "CUSTOMERREGISTERNUMBER")
    private String customerRegisterNumber;

    @Column(name = "CUSTOMERTEL")
    private String customerTel;

    @Column(name = "CUSTOMERTELEX")
    private String customerTelex;
}
