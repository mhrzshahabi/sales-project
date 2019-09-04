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
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INVOICE_SEQ")
	@SequenceGenerator(name = "INVOICE_SEQ", sequenceName = "SEQ_INVOICE_ID",allocationSize = 1)
	@Column(name = "ID", precision = 10)
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false)
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

	@Column(name = "PAID_STATUS")
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

}