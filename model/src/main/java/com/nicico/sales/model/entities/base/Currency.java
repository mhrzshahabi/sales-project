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
	@SequenceGenerator(name = "SEQ_CURRENCY", sequenceName = "SEQ_CURRENCY")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "c_NAME_FA")
	private String nameFa;

	@Column(name = "c_NAME_EN")
	private String nameEn;

	@Column(name = "c_IS_ACTIVE")
	private String isActive;

	@Column(name = "c_SYMBOL")
	private String symbol;

	@Column(name = "c_CODE")
	private String code;
}
