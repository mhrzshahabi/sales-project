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
@Table(name = "TBL_INVOICE_INTERNAL_LC")
public class InvoiceInternalLc extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE_INTERNAL_LC")
	@SequenceGenerator(name = "SEQ_INVOICE_INTERNAL_LC", sequenceName = "SEQ_INVOICE_INTERNAL_LC")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "LCID", length = 100)
	private String lcId;
	@Column(name = "LC_PREFACTOR", length = 100)
	private String lcPreFactor;
	@Column(name = "LC_CUSTOMERID", length = 100)
	private String lcCustomerId;
	@Column(name = "LC_CUSTOMERNAME", length = 100)
	private String lcCustomerName;
	@Column(name = "LC_BANKLC", length = 100)
	private String lcBankLc;
	@Column(name = "BANKLCDESCSHOBEH", length = 2000)
	private String bankLcDescShobeh;
	@Column(name = "LC_GOODSID", precision = 10)
	private Long lcGoodsId;
	@Column(name = "LC_GOODSNAME", length = 1000)
	private String lcGoodName;
	@Column(name = "LC_DATESEDOR", length = 30)
	private String lcDateSedor;
	@Column(name = "LC_DATESARRESED", length = 100)
	private String lcDateSarreceid;
	@Column(name = "LC_MEGHDAR", precision = 10)
	private Long lcMeghdar;
	@Column(name = "LC_PRICE", precision = 10)
	private Long lcPrice;
	@Column(name = "LC_NUMBER", length = 100)
	private String lcNumber;
	@Column(name = "LC_TYPE", precision = 10)
	private Long lcType;
	@Column(name = "LCTYPEDESC", length = 200)
	private String lcTypeDesc;
	@Column(name = "LC_STATE", precision = 10)
	private Long lcState;
	@Column(name = "LCSTATEDESC", length = 200)
	private String lcStateDesc;
	@Column(name = "LC_USER", length = 200)
	private String lcUser;
	@Column(name = "USERNAME", length = 500)
	private String lcUsername;
	@Column(name = "LC_CODEMARKAZHAZINEHLC", length = 100)
	private String lcCodeMarkazHazinehLc;
	@Column(name = "LC_BANKLCMOAMELEH", length = 100)
	private String  lcBankMoameleh;
	@Column(name = "BANKLCMOAMELEHDESCSHOBEH", length = 1000)
	private String lcBankMoamelehDescShobeh;
	@Column(name = "BANKGROUPID", length = 100)
	private String lcBankGroupId;
	@Column(name = "BANKGROUPDESC", length = 1000)
	private String lcBankGroupDesc;
	@Column(name = "STATEINOUT", length = 100)
	private String lcStateInOut;


}