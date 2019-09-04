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
@Table(name = "TBL_CONTRACT_ATTACHMENT")
public class ContractAttachment extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_ATTACHMENT")
	@SequenceGenerator(name = "SEQ_CONTRACT_ATTACHMENT", sequenceName = "SEQ_CONTRACT_ATTACHMENT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
	private Contract contract;

	@Column(name = "CONTRACT_ID")
	private Long contractId;

	@Column(name = "FILE_NAME", nullable = false, length = 100)
	private String fileName;

	@Column(name = "FILE_NEW_NAME", length = 100)
	private String fileNewName;

	@Column(name = "DESCRIPTION", nullable = false, length = 1000)
	private String description;

	@Column(name = "REMARK", length = 1000)
	private String remark;

}
