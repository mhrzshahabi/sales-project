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
@Table(name = "TBL_SHIPMENT_MOISTURE_HEADER")
public class ShipmentMoistureHeader extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SHIPMENT_MOISTURE_HEADER")
	@SequenceGenerator(name = "SEQ_SHIPMENT_MOISTURE_HEADER", sequenceName = "SEQ_SHIPMENT_MOISTURE_HEADER")
	@Column(name = "ID")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", nullable = false, insertable = false, updatable = false)
	private Shipment shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INSPECT_CONTACT_ID", nullable = false, insertable = false, updatable = false)
	private Contact inspectionByContact;

	@Column(name = "INSPECT_CONTACT_ID")
	private Long inspectionByContactId;

	@Column(name = "DESCRIPTION", length = 4000)
	private String description;

	@Column(name = "LOCATION", length = 100)
	private String location;

	@Column(name = "INSPECTION_DATE", length = 100)
	private String inspectionDate;

	@Column(name = "TOTAL_WET_WEIGHT")
	private Double totalWetWeight;

	@Column(name = "AVERAGE_MOISTURE_PERCENT")
	private Double averageMoisturePercent;

	@Column(name = "TOTAL_DRY_WEIGHT")
	private Double totalDryWeight;

	@Column(name = "TOTAL_H2O_WEIGHT")
	private Double totalH2oWeight;

}


