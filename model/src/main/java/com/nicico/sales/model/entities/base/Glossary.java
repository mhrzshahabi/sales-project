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
@Table(name = "TBL_GLOSSARY")
public class Glossary extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "GLOSSARY_SEQ")
	@SequenceGenerator(name = "GLOSSARY_SEQ", sequenceName = "SEQ_GLOSSARY_ID",allocationSize = 1)
	@Column(name = "ID", precision = 10)
	private Long id;

	//SUMMARY
	@Column(name = "SUMMARY", nullable = false, length = 20)
	private String summary;

	//MEANING
	@Column(name = "MEANING", nullable = false, length = 200)
	private String meaning;
}
