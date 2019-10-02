package com.nicico.sales.model.entities.base;


/**
 * mehdi 9802
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
@Table(name = "TBL_BOL_HEADER")
public class BolHeader extends Auditable {


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BOL_HEADER")
	@SequenceGenerator(name = "SEQ_BOL_HEADER", sequenceName = "SEQ_BOL_HEADER")
	@Column(name = "ID")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", nullable = false, insertable = false, updatable = false)
	private Shipment Shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_CONTRACT_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentContract shipmentContract;

	@Column(name = "SHIPMENT_CONTRACT_ID")
	private Long shipmentContractId;

	@Column(name = "f_GROSS_WEIGHT")
	private Double grossWeight;

	@Column(name = "f_NET_WEIGHT")
	private Double netWeight;

	@Column(name = "n_CONTAINER")
	private Long noContainer;

	@Column(name = "n_BUNDLE")
	private Long noBundle;

	@Column(name = "c_BL_NO", nullable = false, length = 100)
	private String blNo;

	@Column(name = "c_SWBL_NO", length = 100)
	private String swBlNo;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "DISCHARGE_port_id", nullable = false, insertable = false, updatable = false)
	private Port portByDischarge;

	@Column(name = "DISCHARGE_port_id")
	private Long PortByDischargeId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SWITCH_PORT_id", nullable = false, insertable = false, updatable = false)
	private Port switchPort;

	@Column(name = "SWITCH_PORT_id")
	private Long switchPortId;

	@Column(name = "n_PALATE")
	private Long noPalete;

	@Column(name = "c_BOL_DATE", length = 100)
	private String bolDate;
}