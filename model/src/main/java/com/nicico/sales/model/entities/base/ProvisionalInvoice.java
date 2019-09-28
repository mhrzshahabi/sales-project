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
@Table(name = "TBL_PROVISIONAL_INVOICE")
public class ProvisionalInvoice extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PROVISIONAL_INVOICE")
	@SequenceGenerator(name = "SEQ_PROVISIONAL_INVOICE", sequenceName = "SEQ_PROVISIONAL_INVOICE")
	@Column(name = "ID")
	private Long id;

	@Column(name = "REF_NO")
	private String refNumber;

	@Column(name = "REF_DATE")
	private String refDate;

	@Column(name = "BOL_NUMBER")
	private String bolNumber;

	@Column(name = "SWITCHED")
	private String switched;

	@Column(name = "PROV_FROM")
	private String from;

	@Column(name = "PROV_TO")
	private String to;

	@Column(name = "NET_WET")
	private Float netWet;

	@Column(name = "PRICE_BASE_FROM")
	private String priceBaseFrom;

	@Column(name = "PRICE_BASE_TO")
	private String priceBaseTO;

	@Column(name = "LME_COPPER")
	private Float LMEcopper;

	@Column(name = "LME_SILVER")
	private Float LMEsilver;

	@Column(name = "LME_GOLD")
	private Float LMEgold;

	@Column(name = "TOTAL_NET_WET")
	private Float totalNetWet;

	@Column(name = "TOTAL_NET_DRY")
	private Float totalNetDry;

	@Column(name = "TOTAL_MOISTURE")
	private Float totalMoisture;

	@Column(name = "SUBTOTAL")
	private Float subtotal;

	@Column(name = "SUBTOTAL_DEDUCTIONS")
	private Float subDeductions;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", nullable = false, insertable = false, updatable = false)
	private Shipment shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTACT_ID", nullable = false, insertable = false, updatable = false)
	private Contact contact;

	@Column(name = "CONTACT_ID")
	private Long contactId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BOL_HEADER_ID", nullable = false, insertable = false, updatable = false)
	private BolHeader bolHeader;

	@Column(name = "BOL_HEADER_ID")
	private Long bolHeaderId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
	private Contract contract;

	@Column(name = "CONTRACT_ID")
	private Long contractId;

	@ManyToOne
	@JoinColumn(name = "MATERIAL_ID", nullable = false, insertable = false, updatable = false)
	private Material material;

	@Column(name = "MATERIAL_ID")
	private Long materialId;
}