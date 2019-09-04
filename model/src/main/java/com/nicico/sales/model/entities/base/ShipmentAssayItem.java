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
@Table(name = "TBL_SHIPMENT_ASSAY_ITEM")
public class ShipmentAssayItem extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SHIPMENT_ASSAY_ITEM_SEQ")
	@SequenceGenerator(name = "SHIPMENT_ASSAY_ITEM_SEQ", sequenceName = "SEQ_SHIPMENT_ASSAY_ITEM_ID",allocationSize = 1)
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ASSAY_HEADER_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentAssayHeader shipmentAssayHeader;

	@Column(name = "ASSAY_HEADER_ID")
	private Long shipmentAssayHeaderId;

	@Column(name = "LOT_NO")
	private Long lotNo;

	@Column(name = "CU")
	private Double cu;

	@Column(name = "AG")
	private Double ag;

	@Column(name = "AU")
	private Double au;
}


