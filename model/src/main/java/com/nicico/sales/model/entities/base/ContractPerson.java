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
@Table(name = "TBL_CONTRACT_PERSON")
public class ContractPerson extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_PERSON")
	@SequenceGenerator(name = "SEQ_CONTRACT_PERSON", sequenceName = "SEQ_CONTRACT_PERSON")
	@Column(name = "ID")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "ContractPerson2contract"))
	private Contract contract;

	@Column(name = "CONTRACT_ID")
	private Long contractId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PERSON_ID", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "ContractPerson2person"))
	private Person person;

	@Column(name = "PERSON_ID")
	private Long personId;

	@Column(name = "STATUS", length = 20)
	private String status;

}
