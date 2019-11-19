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
@Table(name = "TBL_WAREHOUSE_STOCK")
public class WarehouseStock extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WAREHOUSE_STOCK")
	@SequenceGenerator(name = "SEQ_WAREHOUSE_STOCK", sequenceName = "SEQ_WAREHOUSE_STOCK")
	@Column(name = "ID")
	private Long id;

	@Column(name = "WAREHOUSE_NO", length = 20)
	private String warehouseNo;

	@Column(name = "PLANT", length = 20)
	private String plant;

	@Column(name = "YARD_ID")
	private Long yardId;

	@Column(name = "SHEET")
	private Long sheet;

	@Column(name = "BUNDLE")
	private Long bundle;

	@Column(name = "AMOUNT")
	private Double amount;

	@Column(name = "BARREL")
	private Long barrel;

	@Column(name = "LOT")
	private Long lot;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ITEM_ID", nullable = false, insertable = false, updatable = false)
	private MaterialItem materialItem;

	@Column(name = "MATERIAL_ITEM_ID")
	private Long materialId;

}
