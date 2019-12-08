package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_INVOICE_INTERNAL_CUSTOMER")
public class InvoiceInternalCustomer extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE_INTERNAL_CUSTOMER")
	@SequenceGenerator(name = "SEQ_INVOICE_INTERNAL_CUSTOMER", sequenceName = "SEQ_INVOICE_INTERNAL_CUSTOMER")
	@Column(name = "ID", precision = 10)
	private Long id;
	@Column(name = "CUST_ID" , length = 100)
	private String customerId;
	@Column(name = "CUST_NAME" , length = 500)
	private String customerName;
	@Column(name = "CUST_ADDRESS" , length = 4000)
	private String customerAddress;
	@Column(name = "CUST_SHARH" , length = 4000)
	private String customerSharh;
	@Column(name = "CUST_TEL" , length = 100)
	private String customerTel;
	@Column(name = "CUST_EGHTESADNUMBER" , length = 100)
	private String customerEghtesadNumber;
	@Column(name = "CUST_SABTNUMBER" , length = 100)
	private String customerSabtNumber;
	@Column(name = "CUST_POSTCODE" , length = 100)
	private String customerPostCode;
	@Column(name = "CUST_TELEX" , length = 100)
	private String customerTelex;
	@Column(name = "CUST_FAX" , length = 100)
	private String customerFax;
	@Column(name = "CUST_CODENOSA" , length = 100)
	private String customerCodeNosa;
}