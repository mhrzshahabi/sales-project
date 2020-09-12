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
				"CUST_ADDRESS AS C_CUSTOMER_ADDRESS, " +
				"CUST_CODEMARKAZHAZ AS C_CUSTOMER_COST_CENTER_CODE, " +
				"CUST_SHARH AS C_CUSTOMER_DESC, " +
				"CUST_EGHTESADNUMBER AS C_CUSTOMER_ECONOMICAL_NUMBER, " +
				"CUST_FAX AS C_CUSTOMER_FAX, " +
				"CUST_NAME AS C_CUSTOMER_NAME, " +
				"CUST_CODENOSA AS C_CUSTOMER_NOSA_CODE, " +
				"CUST_CODEETEBARENOSA AS C_CUSTOMER_NOSA_CREDIT_CODE, " +
				"CUST_POSTCODE AS C_CUSTOMER_POSTAL_CODE, " +
				"CUST_SABTNUMBER AS C_CUSTOMER_REGISTER_NUMBER, " +
				"CUST_TEL AS C_CUSTOMER_TEL, " +
				"CUST_TELEX AS C_CUSTOMER_TELEX " +
				"FROM " +
				"CUSTOMER1TBL C"
)
public class ViewCustomer {
	@Id
	@Column(name = "ID")
	private String id;

	@Column(name = "C_CUSTOMER_ADDRESS")
	private String customerAddress;

	@Column(name = "C_CUSTOMER_COST_CENTER_CODE")
	private String customerCostCenterCode;

	@Column(name = "C_CUSTOMER_DESC")
	private String customerDesc;

	@Column(name = "C_CUSTOMER_ECONOMICAL_NUMBER")
	private String customerEconomicalNumber;

	@Column(name = "C_CUSTOMER_FAX")
	private String customerFax;

	@Column(name = "C_CUSTOMER_NAME")
	private String customerName;

	@Column(name = "C_CUSTOMER_NOSA_CODE")
	private String customerNosaCode;

	@Column(name = "C_CUSTOMER_NOSA_CREDIT_CODE")
	private String customerNosaCreditCode;

	@Column(name = "C_CUSTOMER_POSTAL_CODE")
	private String customerPostalCode;

	@Column(name = "C_CUSTOMER_REGISTER_NUMBER")
	private String customerRegisterNumber;

	@Column(name = "C_CUSTOMER_TEL")
	private String customerTel;

	@Column(name = "C_CUSTOMER_TELEX")
	private String customerTelex;
}
