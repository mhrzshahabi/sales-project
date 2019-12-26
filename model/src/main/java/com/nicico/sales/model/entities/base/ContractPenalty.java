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
@Table(name = "TBL_CONTRACT_PENALTY")
public class ContractPenalty extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_PENALTY")
	@SequenceGenerator(name = "SEQ_CONTRACT_PENALTY", sequenceName = "SEQ_CONTRACT_PENALTY", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Column(name = "DEDUCTION", length = 4)
	private Double deduction;

	@Column(name = "VALUE", length = 4)
	private Double value;

	@Column(name = "OPERATION", length = 4)
	private String operation;

}
