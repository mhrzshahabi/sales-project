package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.enumeration.FileStatus;
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
public class File extends Auditable {
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

	@Column(name = "E_FILE_STATUS")
	private FileStatus fileStatus;
}
