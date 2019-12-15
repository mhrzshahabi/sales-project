package com.nicico.sales.model.entities.base;


/**
 * EMAMI
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
@Table(name = "TBL_COUNTRY")
public class Country extends Auditable {


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_COUNTRY")
	@SequenceGenerator(name = "SEQ_COUNTRY", sequenceName = "SEQ_COUNTRY", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Column(name = "c_NAME_FA", nullable = false, length = 200)
	private String nameFa;

	@Column(name = "c_NAME_EN", nullable = false, length = 200)
	private String nameEn;

	@Column(name = "c_ISACTIVE")
	private String isActive;

	@Column(name = "c_INV_ID")
	private String invId;

	@Column(name = "c_CODE", nullable = false, length = 200)
	private String code;


}
