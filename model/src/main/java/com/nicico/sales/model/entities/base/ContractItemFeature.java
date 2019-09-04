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
@Table(name = "TBL_CONTRACT_ITEM_FEATURE")
public class ContractItemFeature extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_ITEM_FEATURE")
	@SequenceGenerator(name = "SEQ_CONTRACT_ITEM_FEATURE", sequenceName = "SEQ_CONTRACT_ITEM_FEATURE")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ITEM_ID", nullable = false, insertable = false, updatable = false)
	private ContractItem contractItem;

	@Column(name = "CONTRACT_ITEM_ID")
	private Long contractItemId;

	@Column(name = "FEATURE_ROW", nullable = false, length = 5)
	private Long itemRow;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FEATURE_ID", nullable = false, insertable = false, updatable = false)
	private Feature feature;

	@Column(name = "FEATURE_ID")
	private Long featureId;

	@Column(name = "MIN_VALUE")
	private Double minValue;

	@Column(name = "MAX_VALUE")
	private Double maxValue;

	@Column(name = "AVG_VALUE")
	private Double avgValue;

	@Column(name = "TOLORANCE")
	private Double tolorance;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "RATE_ID", nullable = false, insertable = false, updatable = false)
	private Rate rate;

	@Column(name = "RATE_ID")
	private Long rateId;

	@Column(name = "PAYABLE_IF_GRATER")
	private Double payableIfGraterThan;

	@Column(name = "DISCOUNT_IF_GRATER")
	private Double discountIfGraterThan;

	@Column(name = "PAYMENT_PERCENT")
	private Double paymentPercent;

	@Column(name = "TC")
	private Double TC;

	@Column(name = "RC")
	private Double RC;

	@Column(name = "UNIT_DIDUCTION")
	private String unitDiduction;

}
