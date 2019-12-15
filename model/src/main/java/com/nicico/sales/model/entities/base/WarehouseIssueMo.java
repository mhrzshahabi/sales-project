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
@Table(name = "TBL_WAREHOUSE_ISSUE_MO")
public class WarehouseIssueMo extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_ISSUE")
	@SequenceGenerator(name = "SEQ_ISSUE", sequenceName = "SEQ_ISSUE", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Warehouseissuemo2shipment"))
	private Shipment shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "WAREHOUSELOT_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Warehouseissuemo2lot"))
	private WarehouseLot warehouseLot;

	@Column(name = "WAREHOUSELOT_ID")
	private Long warehouseLotId;

	@Column(name = "CONTAINER_NO",length = 50)
	private String containerNo;

	@Column(name = "AMOUNT_CUSTOM")
	private Double amountCustom;

	@Column(name = "SEALED_CUSTOM",length = 50)
	private String sealedCustom;

	@Column(name = "SEALED_INSPECTOR",length = 50)
	private String sealedInspector;

	@Column(name = "SEALED_SHIP",length = 50)
	private String sealedShip;

	@Column(name = "EMPTY_WEIGHT")
	private Double emptyWeight;

}