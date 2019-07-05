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
@Table(name = "TBL_WAREHOUSE_LOT", schema = "SALES")
public class WarehouseLot extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_WAREHOUSE_LOT")
	@SequenceGenerator(name = "SEQ_WAREHOUSE_LOT", sequenceName = "SALES.SEQ_WAREHOUSE_LOT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "c_WAREHOUSE_NO", nullable = false, length = 20)
	private String warehouseNo;

	@ManyToOne
	@JoinColumn(name = "MATERIAL_ID", nullable = false, insertable = false, updatable = false)
	private Material material;

	@Column(name = "MATERIAL_ID")
	private Long materialId;

	@Column(name = "PLANT", nullable = false, length = 100)
	private String plant;

	@Column(name = "LOT_NAME", nullable = false, length = 20)
	private String lotName;

	@Column(name = "CU")
	private Double cu;

	@Column(name = "AG")
	private Double ag;

	@Column(name = "AU")
	private Double au;

	@Column(name = "DMT")
	private Double dmt;

	@Column(name = "MO")
	private Double mo;

	@Column(name = "SI")
	private Double si;

	@Column(name = "PB")
	private Double pb;

	@Column(name = "S")
	private Double s;

	@Column(name = "C")
	private Double c;

	@Column(name = "P")
	private String p;

	@Column(name = "SIZE1", length = 20)
	private String size1;

	@Column(name = "SIZE1_VALUE")
	private Double size1Value;

	@Column(name = "SIZE2", length = 20)
	private String size2;

	@Column(name = "SIZE2_VALUE")
	private Double size2Value;

	@Column(name = "WEIGHT_KG")
	private Double weightKg;

	@Column(name = "GROSS_WEIGHT")
	private Double grossWeight;

}
