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

	@Column(name = "PLANT")
	private String plant;

	@Column(name = "YARD")
	private String yard;

	@Column(name = "SHEET_NO")
	private String sheetNo;

	@Column(name = "BUNDLE_NO")
	private String bundleNo;

	@Column(name = "GROSS_NO")
	private String gross;

	@Column(name = "NET_NO")
	private String net;

	@Column(name = "BARREL_NO")
	private String barrelNo;

	@Column(name = "LOT_NO")
	private String lotNo;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ITEM_ID", nullable = false, insertable = false, updatable = false)
	private MaterialItem materialItem;

	@Column(name = "MATERIAL_ITEM_ID")
	private Long materialId;

}
