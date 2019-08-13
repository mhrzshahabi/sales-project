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
@Table(name = "TBL_CONTRACT_PENALTY", schema = "SALES")
public class ContractPenalty extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "CONTRACT_PENALTY")
	@SequenceGenerator(name = "CONTRACT_PENALTY", sequenceName = "SALES.CONTRACT_PENALTY")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ITEM_FEATURE_ID", nullable = false, insertable = false, updatable = false)
	private ContractItemFeature contractItemFeature;

	@Column(name = "CONTRACT_ITEM_FEATURE_ID")
	private Long contractItemFeatureId;

	@Column(name = "DEDUCTION", length = 4)
	private Float deduction;

	@Column(name = "VALUE", length = 4)
	private Float value;

	@Column(name = "OPERATION", length = 4)
	private String operation;
}
