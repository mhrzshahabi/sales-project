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
@Table(name = "TBL_SHIPMENT_ASSAY_HEADER")
public class ShipmentAssayHeader extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SHIPMENT_ASSAY_HEADER")
	@SequenceGenerator(name = "SEQ_SHIPMENT_ASSAY_HEADER", sequenceName = "SEQ_SHIPMENT_ASSAY_HEADER", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "shipmntassayH2shipment"))
	private Shipment shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INSPECT_CONTACT_ID", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "shipmntassayH2inspector"))
	private Contact inspectionByContact;

	@Column(name = "INSPECT_CONTACT_ID")
	private Long inspectionByContactId;

	@Column(name = "DESCRIPTION", length = 4000)
	private String description;

	@Column(name = "LOCATION", length = 100)
	private String location;

	@Column(name = "INSPECTION_DATE", length = 100)
	private String inspectionDate;

	@Column(name = "AVERAGE_CU_PERCENT")
	private Double averageCuPercent;

	@Column(name = "AVERAGE_AU_PERCENT")
	private Double averageAuPercent;

	@Column(name = "AVERAGE_AG_PERCENT")
	private Double averageAgPercent;

	@Column(name = "TOTAL_DRY_WEIGHT")
	private Double totalDryWeight;

}


