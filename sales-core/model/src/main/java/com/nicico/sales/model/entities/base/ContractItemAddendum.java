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
@Table(name = "TBL_CONTRACT_ITEM_ADDENDUM", schema = "SALES")
public class ContractItemAddendum extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_ITEM_ADDENDUM")
	@SequenceGenerator(name = "SEQ_CONTRACT_ITEM_ADDENDUM", sequenceName = "SALES.SEQ_CONTRACT_ITEM_ADDENDUM")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "ADDENDUM_DESC", length = 1000)
	private String addendumDesc;

	@ManyToOne
	@JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
	private Contract contract;

	@Column(name = "CONTRACT_ID")
	private Long contractId;

	@ManyToOne
	@JoinColumn(name = "CONTRACT_ITEM_ID", nullable = false, insertable = false, updatable = false)
	private ContractItem contractItem;

	@Column(name = "CONTRACT_ITEM_ID")
	private Long contractItemId;
}
