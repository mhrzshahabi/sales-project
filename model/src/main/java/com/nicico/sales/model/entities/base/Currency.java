package com.nicico.sales.model.entities.base;


/**
 * ESTERABEH
 */

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
@Table(name = "TBL_CURRENCY")
public class Currency extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CURRENCY")
	@SequenceGenerator(name = "SEQ_CURRENCY", sequenceName = "SEQ_CURRENCY", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Column(name = "c_NAME_FA",length = 100)
	private String nameFa;

	@Column(name = "c_NAME_EN",length = 100)
	private String nameEn;

	@Column(name = "c_SYMBOL",length = 20)
	private String symbol;

}
