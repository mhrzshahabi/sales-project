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
@Table(name = "TBL_GROUPS_PERSON", schema = "SALES")
public class GroupsPerson extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_GROUPS_PERSON")
	@SequenceGenerator(name = "SEQ_GROUPS_PERSON", sequenceName = "SALES.SEQ_GROUPS_PERSON")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "GROUPS_ID", nullable = false, insertable = false, updatable = false)
	private Groups groups;

	@Column(name = "GROUPS_ID")
	private Long groupsId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "PERSON_ID", nullable = false, insertable = false, updatable = false)
	private Person person;

	@Column(name = "PERSON_ID")
	private Long personId;

	@Column(name = "REMARK", length = 200)
	private String desc;

}
