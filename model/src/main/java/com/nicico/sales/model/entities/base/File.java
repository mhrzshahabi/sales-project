package com.nicico.sales.model.entities.base;

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
@Table(name = "TBL_FILE")
public class File {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FILE")
	@SequenceGenerator(name = "SEQ_FILE", sequenceName = "SEQ_FILE", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Column(name = "C_ENTITY_NAME")
	private String entityName;

	@Column(name = "N_RECORD_ID")
	private Long recordId;

	@Column(name = "C_FILE_KEY")
	private String fileKey;
}
