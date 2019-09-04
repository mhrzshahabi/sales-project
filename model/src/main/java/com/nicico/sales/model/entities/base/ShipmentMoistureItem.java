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
@Table(name = "TBL_SHIPMENT_MOISTURE_ITEM")
public class ShipmentMoistureItem extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SHIPMENT_MOISTURE_ITEM_SEQ")
	@SequenceGenerator(name = "SHIPMENT_MOISTURE_ITEM_SEQ", sequenceName = "SEQ_SHIPMENT_MOISTURE_ITEM_ID",allocationSize = 1)
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MOISTURE_HEADER_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentMoistureHeader shipmentMoistureHeader;

	@Column(name = "MOISTURE_HEADER_ID")
	private Long shipmentMoistureHeaderId;

	@Column(name = "LOT_NO")
	private Long lotNo;

	@Column(name = "WET_WEIGHT")
	private Double wetWeight;

	@Column(name = "MOISTURE_PERCENT")
	private Double moisturePercent;

	@Column(name = "DRY_WEIGHT")
	private Double dryWeight;

	@Column(name = "H2O_WEIGHT")
	private Double totalH2oWeight;
}


