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
@Table(name = "TBL_EXPORT")
public class Export extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_EXPORT")
	@SequenceGenerator(name = "SEQ_EXPORT", sequenceName = "SEQ_EXPORT")
	@Column(name = "ID")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ID", nullable = false, insertable = false, updatable = false)
	private Material material;

	@Column(name = "MATERIAL_ID")
	private Long materialId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "COUNTRY_ID", nullable = false, insertable = false, updatable = false)
	private Country country;

	@Column(name = "COUNTRY_ID")
	private Long countryId;

	@Column(name = "LOADING_NO", nullable = false, length = 20)
	private String loadingLetterNo;

	@Column(name = "LOADING_DATE", nullable = false, length = 20)
	private String loadingLetterDate;

	@Column(name = "AMOUNT", nullable = false)
	private Double amount;

	@Column(name = "CONTAINER_QUANTITY")
	private Double containerQuantity;

	@Column(name = "SHIP_DATE", nullable = false, length = 20)
	private String shipDate;

	@Column(name = "CARGO", nullable = false, length = 200)
	private String cargo;

}
