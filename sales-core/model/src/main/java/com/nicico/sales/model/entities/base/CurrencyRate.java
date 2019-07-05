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
@Table(name = "TBL_CURRENCY_RATE", schema = "SALES")
public class CurrencyRate extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CURRENCY_RATE")
	@SequenceGenerator(name = "SEQ_CURRENCY_RATE", sequenceName = "SALES.SEQ_CURRENCY_RATE")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "C_DATE")
	private String curDate;

	@Column(name = "c_IRR_USD")
	private String irrUsd;

	@Column(name = "c_EUR_USD")
	private String eurUsd;

	@Column(name = "c_AED_USD")
	private String aedUsd;

	@Column(name = "c_RMB_USD")
	private String rmbUsd;
}
