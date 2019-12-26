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
@Table(name = "TBL_COST")
public class Cost extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_COST")
	@SequenceGenerator(name = "SEQ_COST", sequenceName = "SEQ_COST", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Cost2shipment"))
	private Shipment Shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SOURCE_INSPECTOR_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Cost2contactinspector_S"))
	private Contact sourceInspector;

	@Column(name = "SOURCE_INSPECTOR_ID")
	private Long sourceInspectorId;

	@Column(name = "SOURCE_INSPEC_COST")
	private Double sourceInspectionCost;

	@Column(name = "SOURCE_INSPEC_CUR", length = 20)
	private String sourceInspectionCurrency;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "DEST_INSPECTOR_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Cost2contactinspector_d"))
	private Contact destinationInspector;

	@Column(name = "DEST_INSPECTOR_ID")
	private Long destinationInspectorId;

	@Column(name = "DEST_INSPEC_COST")
	private Double destinationInspectionCost;

	@Column(name = "DEST_INSPEC_CUR", length = 20)
	private String destinationInspectionCurrency;

	@Column(name = "OTHER_COST")
	private Double otherCost;

	@Column(name = "BEFORE_PAID")
	private Double beforePaid;

	@Column(name = "OTHER_COST_CUR", length = 20)
	private String otherCostCurrency;

	@Column(name = "SARCHESHMEH_LAB_COST")
	private Long sarcheshmehLabCost;

	@Column(name = "UMPIRE_COST")
	private Double umpireCost;

	@Column(name = "UMPIRE_COST_CUR", length = 20)
	private String umpireCostCurrency;

	@Column(name = "SOURCE_GOLD")
	private Double sourceGold;

	@Column(name = "SOURCE_SILVER")
	private Double sourceSilver;

	@Column(name = "SOURCE_COPPER")
	private Double sourceCopper;

	@Column(name = "SOURCE_MOLYBDENUM")
	private Double sourceMolybdenum;

	@Column(name = "DEST_GOLD")
	private Double destinationGold;

	@Column(name = "DEST_SILVER")
	private Double destinationSilver;

	@Column(name = "DEST_COPPER")
	private Double destinationCopper;

	@Column(name = "DEST_MOLYBDENUM")
	private Double destinationMolybdenum;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INSURANCE_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Cost2contactinsurance"))
	private Contact insurance;

	@Column(name = "INSURANCE_ID")
	private Long insuranceId;

	@Column(name = "INSURANCE_COST")
	private Double insuranceCost;

	@Column(name = "INSURANCE_COST_CUR", length = 20)
	private String insuranceCostCurrency;

	@Column(name = "INSURANCE_CLAUSE", length = 20)
	private String insuranceClause;

	@Column(name = "INVENTORY_RENT_COST")
	private Long inventortRentCost;

	@Column(name = "POST_COST")
	private Long postCost;

	@Column(name = "THC_COST")
	private Double thcCost;

	@Column(name = "BL_FEE_COST")
	private Double blFeeCost;

	@Column(name = "DEMAND_COST")
	private Double demandCost;

	@Column(name = "DEMAND_COST_CUR", length = 20)
	private String demandCurrency;

	@Column(name = "CONTRACTOR_COST")
	private Double contractorCost;

	@Column(name = "COUNTER_COST")
	private Double counterCost;

	@Column(name = "DISINFECTION_COST")
	private Double disinfectionCost;

	@Column(name = "PORT_COST")
	private Double portCost;

}