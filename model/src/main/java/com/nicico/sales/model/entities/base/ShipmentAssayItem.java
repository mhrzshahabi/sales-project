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
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SHIPMENT_ASSAY_ITEM")
	@SequenceGenerator(name = "SEQ_SHIPMENT_ASSAY_ITEM", sequenceName = "SEQ_SHIPMENT_ASSAY_ITEM")
	@Column(name = "ID")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ASSAY_HEADER_ID", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "shipmntassay_i2shipassayH"))
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


