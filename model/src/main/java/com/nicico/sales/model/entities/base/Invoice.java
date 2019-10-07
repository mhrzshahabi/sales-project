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
@Table(name = "TBL_INVOICE")
public class Invoice extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE")
	@SequenceGenerator(name = "SEQ_INVOICE", sequenceName = "SEQ_INVOICE")
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "INVOICE2SHIPMENT"))
	private Shipment Shipment;

	@Column(name = "SHIPMENT_ID", length = 10)
	private Long shipmentId;

	@Column(name = "INVOICE_NO", length = 100)
	private String invoiceNo;

	@Column(name = "INVOIC_DATE", length = 20)
	private String invoiceDate;

	@Column(name = "INVOICE_TYPE", length = 20)
	private String invoiceType;

	@Column(name = "NET")
	private Float net;

	@Column(name = "GRASS")
	private Float grass;

	@Column(name = "UNIT_PRICE")
	private Float unitPrice;

	@Column(name = "UNIT_PRICE_CUR", length = 10)
	private String unitPriceCurrency;

	@Column(name = "INVOICE_VALUE")
	private Float invoiceValue;

	@Column(name = "INVOICE_VALUE_CUR", length = 10)
	private String invoiceValueCurrency;

	@Column(name = "PAID_PERCENT")
	private Float paidPercent;

	@Column(name = "PAID_STATUS", length = 10)
	private String paidStatus;

	@Column(name = "DEPRECIATION")
	private Float Depreciation;

	@Column(name = "OTHER_COST")
	private Float otherCost;

	@Column(name = "GOLD")
	private Float gold;

	@Column(name = "SILVER")
	private Float silver;

	@Column(name = "COPPER")
	private Float copper;

	@Column(name = "MOLYBDENUM")
	private Float molybdenum;

	@Column(name = "MOLYBDENUM_UNIT_PRICE")
	private Float molybdJenumUnitPrice;

	@Column(name = "COPPER_UNIT_PRICE")
	private Float copperUnitPrice;

	@Column(name = "SILVER_UNIT_PRICE")
	private Float silverUnitPrice;

	@Column(name = "GOLD_UNIT_PRICE")
	private Float goldUnitPrice;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BOL_HEADER_ID", insertable = false, updatable = false)
	private BolHeader bolHeader;

	@Column(name = "BOL_HEADER_ID")
	private Long bolHeaderId;

	@Column(name = "PRICE_BASE", length = 255)
	private String priceBase;

	@Column(name = "MOLYBDENUM_CONTENT")
	private Float molybdenumContent;

	@Column(name = "COMMERCIAL_INVOICE_VALUE")
	private Float commercialInvoceValue;

	@Column(name = "COMMERCIAL_INVOICE_VALUE_NET")
	private Float commercialInvoceValueNet;

	@Column(name = "INVOIVE_VALUE_D")
	private Float invoiceValueD;

	@Column(name = "RATE_BASE", length = 255)
	private String rateBase;

	@Column(name = "RATE2DOLLAR")
	private Float rate2dollar;

	@Column(name = "INVOIVE_VALUE_UP")
	private Float invoiceValueUp;

	@Column(name = "COPPER_INS")
	private Float copperIns;

	@Column(name = "COPPER_DED")
	private Float copperDed;

	@Column(name = "COPPER_CAL")
	private Float copperCal;

	@Column(name = "SILVER_INS")
	private Float silverIns;

	@Column(name = "SILVER_DED")
	private Float silverDed;

	@Column(name = "SILVER_OZ")
	private Float silverOun;

	@Column(name = "SILVER_CAL")
	private Float silverCal;

	@Column(name = "GOLD_INS")
	private Float goldIns;

	@Column(name = "GOLD_DED")
	private Float goldDed;

	@Column(name = "GOLD_OZ")
	private Float goldOun;

	@Column(name = "GOLD_CAL")
	private Float goldCal;

	@Column(name = "SUB_TOTAL")
	private Float subTotal;

	@Column(name = "TREAT_COST")
	private Float treatCost;

	@Column(name = "RC_CU")
	private Float refinaryCostCU;

	@Column(name = "RC_CU_PER")
	private Float refinaryCostCUPer;

	@Column(name = "RC_CU_CAL")
	private Float refinaryCostCUCal;

	@Column(name = "RC_CU_TOT")
	private Float refinaryCostCUTot;

	@Column(name = "RG_AG")
	private Float refinaryCostAG;

	@Column(name = "RC_AG_PER")
	private Float refinaryCostAGPer;

	@Column(name = "RC_AG_TOT")
	private Float refinaryCostAGTot;

	@Column(name = "RC_AU")
	private Float refinaryCostAU;

	@Column(name = "RC_AU_PER")
	private Float refinaryCostAUPer;

	@Column(name = "RC_AU_TOT")
	private Float refinaryCostAUTot;

	@Column(name = "SUB_TOTAL_DEDUCTION")
	private Float subTotalDeduction;

	@Column(name = "PRICE_REFERENCE", length = 255)
	private String priceReference;

	@Column(name = "PRICE_FUNCTION", length = 255)
	private String priceFunction;

	@Column(name = "PRICE_FROM_DATE", length = 255)
	private String priceFromDate;

	@Column(name = "PRICE_TO_DATE", length = 255)
	private String priceToDate;

	@Column(name = "SELLERID")
	private Long sellerId;

	@Column(name = "BUYERID")
	private Long buyerId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SELLERID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "INVOICE2CONTACT_SELLER"))
	private Contact seller;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BUYERID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "INVOICE2CONTACT_BUYER"))
	private Contact buyer;

	@Column(name = "PROCESSID")
	private String processId;


}