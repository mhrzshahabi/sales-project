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
@Table(name = "TBL_UNIT", schema = "SALES")
public class Unit extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_UNIT")
	@SequenceGenerator(name = "SEQ_UNIT", sequenceName = "SALES.SEQ_UNIT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "c_CODE", nullable = false, length = 100)
	private String code;

	@Column(name = "c_NAME_FA", nullable = false, length = 200)
	private String nameFA;

	@Column(name = "c_NAME_EN", nullable = false, length = 200)
	private String nameEN;

	@Column(name = "c_SYMBOL")
	private String symbol;

	@Column(name = "n_DECIMAL_DIGITS")
	private Long decimalDigit;
}