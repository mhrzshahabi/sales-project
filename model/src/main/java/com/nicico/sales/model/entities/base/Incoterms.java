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
@Table(name = "TBL_INCOTERMS", schema = "SALES")
public class Incoterms extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INCOTERMS")
	@SequenceGenerator(name = "SEQ_INCOTERMS", sequenceName = "SALES.SEQ_INCOTERMS")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "CODE", nullable = false, length = 100)
	private String code;

	@Column(name = "WORKS", nullable = false, length = 10)
	private Boolean works;

	@Column(name = "CARRIER", length = 10)
	private Boolean carrier;

	@Column(name = "ALONGSIDE_SHIP", length = 10)
	private Boolean alongSideShip;

	@Column(name = "ON_BOARD", length = 10)
	private Boolean onBoard;

	@Column(name = "ARRIVAL", length = 10)
	private Boolean arrival;

	@Column(name = "TERMINAL", length = 10)
	private Boolean terminal;

	@Column(name = "DESTINATION", length = 10)
	private Boolean destination;

	@Column(name = "WAREHOUSE", length = 10)
	private Boolean warehouse;

	@Column(name = "EXPENSES", length = 10)
	private String expenses;

	@Column(name = "NAMED_PLACE", length = 10)
	private String namedPlace;

	@Column(name = "NAMED_PORT", length = 10)
	private String namedPort;
}
