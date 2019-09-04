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
@Table(name = "TBL_FEATURE")
public class Feature extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FEATURE_SEQ")
	@SequenceGenerator(name = "FEATURE_SEQ", sequenceName = "SEQ_FEATURE_ID",allocationSize = 1)
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "CODE", nullable = false, length = 100)
	private String code;

	@Column(name = "NAME_FA", nullable = false, length = 200)
	private String nameFA;

	@Column(name = "NAME_EN", nullable = false, length = 200)
	private String nameEN;

	@Column(name = "SYMBOL")
	private String symbol;

	@Column(name = "DECIMAL_DIGITS")
	private Long decimalDigit;
}
