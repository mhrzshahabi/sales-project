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
@Table(name = "TBL_INVOICE_ITEM")
public class InvoiceItem extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE")
	@SequenceGenerator(name = "SEQ_INVOICE", sequenceName = "SEQ_INVOICE", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INVOICE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "invoiceItem2invoice"))
	private Invoice invoice;

	@Column(name = "INVOICE_ID")
	private Long invoiceId;

	@Column(name = "UP_DOWN", length = 10)
	private String upDown;

	@Column(name = "LESS_PLUS", length = 10)
	private String lessPlus;

	@Column(name = "DESCRIPTION", length = 4000)
	private String description;

	@Column(name = "ORIGIN_VALUE")
	private Double originValue;

	@Column(name = "ORIGIN_VALUE_CUR", length = 10)
	private String originValueCurrency;

	@Column(name = "TARGET_VALUE")
	private Double targetValue;

	@Column(name = "TARGET_VALUE_CUR", length = 10)
	private String targetValueCurrency;

	@Column(name = "CONVERSION_RATE")
	private Double conversionRate;

	@Column(name = "RATE_DATE", length = 10)
	private String dateRate;

	@Column(name = "RATE_REFERENCE", length = 100)
	private String rateReference;



}