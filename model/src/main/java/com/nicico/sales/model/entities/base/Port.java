package com.nicico.sales.model.entities.base;

/**
 * Ashouri
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
@Table(name = "TBL_PORT", schema = "SALES")
public class Port extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PORT")
	@SequenceGenerator(name = "SEQ_PORT", sequenceName = "SALES.SEQ_PORT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "COUNTRY_ID", insertable = false, updatable = false)
	private Country country;

	@Column(name = "COUNTRY_ID")
	private Long countryId;

	@Column(name = "c_PORT", length = 4000)
	private String port;

	@Column(name = "c_LOA", length = 100)
	private String loa;

	@Column(name = "c_BEAM", length = 100)
	private String beam;

	@Column(name = "c_ARRIVAL", length = 100)
	private String arrival;

}