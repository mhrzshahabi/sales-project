package com.nicico.sales.model.entities.base;

/**
 * EMAMI
 */

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
@Table(name = "TBL_SHIPMENT")
public class Shipment extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT")
	@SequenceGenerator(name = "SEQ_SHIPMENT", sequenceName = "SEQ_SHIPMENT")
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_SHIPMENT_ID", insertable = false, updatable = false)
	private ContractShipment contractShipment;

	@Column(name = "CONTRACT_SHIPMENT_ID")
	private Long contractShipmentId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTACT_ID", insertable = false, updatable = false)
	private Contact contact;

	@Column(name = "CONTACT_ID")
	private Long contactId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_HEADER_ID", insertable = false, updatable = false)
	private ShipmentHeader shipmentHeader;

	@Column(name = "SHIPMENT_HEADER_ID")
	private Long shipmentHeaderId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ID", insertable = false, updatable = false)
	private Contract contract;

	@Column(name = "CONTRACT_ID")
	private Long contractId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ID", insertable = false, updatable = false)
	private Material material;

	@Column(name = "MATERIAL_ID")
	private Long materialId;

	@Column(name = "AMOUNT", nullable = false)
	private Double amount;

	@Column(name = "CONTAINER")
	private Long noContainer;

	@Column(name = "CONTAINER_TYPE", length = 20)
	private String containerType;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "LOADING", insertable = false, updatable = false)
	private Port portByLoading;

	@Column(name = "LOADING")
	private Long portByLoadingId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "DISCHARGE", insertable = false, updatable = false)
	private Port portByDischarge;

	@Column(name = "DISCHARGE")
	private Long portByDischargeId;

	@Column(name = "DISCHARGE_ADDRESS", length = 4000)
	private String dischargeAddress;

	@Column(name = "DESCRIPTION", length = 4000)
	private String description;

	@Column(name = "STATUS", length = 20)
	private String status;

	@Column(name = "MONTH", length = 20)
	private String month;

	@Column(name = "CREATE_DATE", length = 20)
	private String createDate;

	@Column(name = "FILE_NAME", length = 100)
	private String fileName;

	@Column(name = "NEW_FILE_NAME", length = 100)
	private String newFileName;

	@Column(name = "SHIPMENT_TYPE", length = 100)
	private String shipmentType;

	@Column(name = "LAYCAN", length = 100)
	private String laycan;

	@Column(name = "SWITCH_BL_NUMBERS", length = 4000)
	private String switchBl;

	@Column(name = "SWB", length = 100)
	private String swb;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SWITCH_PORT", insertable = false, updatable = false)
	private Port switchPort;

	@Column(name = "SWITCH_PORT")
	private Long switchPortId;

	@Column(name = "NO_BUNDLE", length = 100)
	private String noBundle;

	@Column(name = "LOADING_LETTER", length = 100)
	private String loadingLetter;

	@Column(name = "BL_NUMBERS", length = 4000)
	private String blNumbers;

	@Column(name = "NO_OF_BL")
	private long numberOfBLs;

	@Column(name = "BL_DATE", length = 20)
	private String blDate;

	@Column(name = "SW_BL_DATE", length = 20)
	private String swBlDate;

	@Column(name = "CONSIGNEE", length = 100)
	private String consignee;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "AGENT", insertable = false, updatable = false)
	private Contact contactByAgent;

	@Column(name = "AGENT")
	private Long contactByAgentId;

	@Column(name = "VESSEL_NAME", length = 500)
	private String vesselName;

	@Column(name = "FREIGHT")
	private Double freight;

	@Column(name = "TOTAL_FREIGHT")
	private Double totalFreight;

	@Column(name = "FREIGHT_CUR", length = 20)
	private String freightCurrency;

	@Column(name = "PRE_FREIGHT")
	private Double preFreight;

	@Column(name = "PRE_REIGHT_CUR", length = 20)
	private String preFreightCurrency;

	@Column(name = "POST_FREIGHT")
	private Double postFreight;

	@Column(name = "POST_REIGHT_CUR", length = 20)
	private String postFreightCurrency;

	//drum
	@Column(name = "NO_BARREL", length = 100)
	private String noBarrel;

	@Column(name = "NO_PALETE", length = 100)
	private String noPalete;

	@Column(name = "DEMURRAGE")
	private Double demurrage;

	@Column(name = "DISPATCH")
	private Double dispatch;

	@Column(name = "DETENSION")
	private Double detention;


	@Column(name = "BOOKING_NO_cat")
	private String bookingCat;

}
