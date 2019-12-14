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
@Table(name = "TBL_DAILY_WAREHOUSE")
public class DailyWarehouse extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_DAILY_WAREHOUSE")
	@SequenceGenerator(name = "SEQ_DAILY_WAREHOUSE", sequenceName = "SEQ_DAILY_WAREHOUSE")
	@Column(name = "ID")
	private Long id;

	@Column(name = "WAREHOUSE_NO", nullable = false, length = 20)
	private String warehouse;

	@Column(name = "TO_DAY", nullable = false, length = 20)
	private String toDay;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ID", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Dailywarehose2material"))
	private Material material;

	@Column(name = "MATERIAL_ID")
	private Long materialId;

	@Column(name = "PLANT", nullable = false, length = 100)
	private String plant;

	@Column(name = "OPERATION", nullable = false, length = 20)
	private String operation;

	@Column(name = "AMOUNT", nullable = false)
	private Double amount;

	@Column(name = "PACKING_TYPE", length = 100)
	private String packingType;

	@Column(name = "PACKING_QUANTITY")
	private Double packingQuantity;

}
