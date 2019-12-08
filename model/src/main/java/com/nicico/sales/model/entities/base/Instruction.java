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
@Table(name = "TBL_INSTRUCTION")
public class Instruction extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INSTRUCTION")
	@SequenceGenerator(name = "SEQ_INSTRUCTION", sequenceName = "SEQ_INSTRUCTION")
	@Column(name = "ID")
	private Long id;

	@Column(name = "TITLE_Instruction", nullable = false, length = 4000)
	private String titleInstruction;

	@Column(name = "DISABLE_DATE", nullable = false, length = 200)
	private String disableDate;

	@Column(name = "RUN_DATE", nullable = false, length = 200)
	private String runDate;
}
