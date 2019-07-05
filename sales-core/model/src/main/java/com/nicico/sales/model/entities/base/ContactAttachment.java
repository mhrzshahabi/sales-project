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
@Table(name = "TBL_CONTACT_ATTACHMENT", schema = "SALES")
public class ContactAttachment extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTACT_ATTACHMENT")
	@SequenceGenerator(name = "SEQ_CONTACT_ATTACHMENT", sequenceName = "SALES.SEQ_CONTACT_ATTACHMENT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "CONTACT_ID", nullable = false, insertable = false, updatable = false)
	private Contact contract;

	@Column(name = "CONTACT_ID")
	private Long contactId;

	@Column(name = "FILE_NAME", nullable = false, length = 100)
	private String fileName;

	@Column(name = "FILE_NEW_NAME", length = 100)
	private String fileNewName;

	@Column(name = "DESCRIPTION", nullable = false, length = 1000)
	private String description;

	@Column(name = "REMARK", length = 1000)
	private String remark;
}
