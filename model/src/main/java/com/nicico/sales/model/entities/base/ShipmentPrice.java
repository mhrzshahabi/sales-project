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
@Table(name = "TBL_SHIPMENT_PRICE")
public class ShipmentPrice extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_PRICE")
	@SequenceGenerator(name = "SEQ_SHIPMENT_PRICE", sequenceName = "SEQ_SHIPMENT_PRICE")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FLAG", nullable = false, insertable = false, updatable = false)
	private Country countryByflag;

	@Column(name = "FLAG")
	private Long countryByflagId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INQUIRY_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentInquiry shipmentInquiry;

	@Column(name = "INQUIRY_ID")
	private Long shipmentInquiryId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", nullable = false, insertable = false, updatable = false)
	private Shipment shipment;

	@Column(name = "SHIPMENT_ID")
	private Long ShipmentId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_HEADER_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentHeader shipmentHeader;

	@Column(name = "SHIPMENT_HEADER_ID")
	private Long shipmentHeaderId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPPING_COMPANY", nullable = false, insertable = false, updatable = false)
	private Contact contactByCompany;

	@Column(name = "SHIPPING_COMPANY")
	private Long contactByCompanyId;

	@Column(name = "CAPACITY")
	private Double capacity;

	@Column(name = "LAYCAN_START")
	private String laycanStart;

	@Column(name = "CRANES_NO", length = 20)
	private String cranesNO;

	@Column(name = "SWB_COST", length = 20)
	private Double swbCost;

	@Column(name = "LAYCAN_END", length = 20)
	private String laycanEnd;

	@Column(name = "VAT", length = 20)
	private Double vat;

	@Column(name = "BL_FREE", length = 20)
	private Double BL_FREE;

	@Column(name = "RATE", length = 20)
	private Double rate;

	@Column(name = "THC", length = 20)
	private Double THC;

	@Column(name = "LOADINGRATE", length = 100)
	private String loadingRate;

	@Column(name = "DISCHARGERATE", length = 100)
	private String dischargeRate;

	@Column(name = "DEMURRAGE")
	private Double demurrage;

	@Column(name = "DISPATCH")
	private Double dispatch;

	@Column(name = "FREIGHT")
	private Double freight;

	@Column(name = "VESSEL_NAME", length = 1000)
	private String vesselName;

	@Column(name = "YEAROFBUILT", length = 20)
	private String yearOfBuilt;

	@Column(name = "IMO", length = 20)
	private String imo;

	@Column(name = "HOLDS", length = 100)
	private String holds;

	@Column(name = "HATCH", length = 100)
	private String hatch;

	@Column(name = "CLASS_TYPE", length = 100)
	private String classType;

	@Column(name = "ETA", length = 100)
	private String ETA;


}
