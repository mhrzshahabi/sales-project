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
@Table(name = "TBL_GROUPS", schema = "SALES")
public class Groups extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_GROUPS")
	@SequenceGenerator(name = "SEQ_GROUPS", sequenceName = "SALES.SEQ_GROUPS")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "GROUPS_NAME", nullable = false, length = 200)
	private String groupsName;

}
