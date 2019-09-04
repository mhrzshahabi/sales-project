package com.nicico.sales.model.entities.base;

/**
 * mehdi 9802
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
@Table(name = "TBL_BOL_ITEM")
public class BolItem extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BOL_ITEM")
	@SequenceGenerator(name = "SEQ_BOL_ITEM", sequenceName = "SEQ_BOL_ITEM")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BOL_HEADER_ID", nullable = false, updatable = false, insertable = false)
	private BolHeader bolHeader;

	@Column(name = "BOL_HEADER_ID")
	private Long bolHeaderId;

	@Column(name = "f_GROSS_WEIGHT")
	private Double grossWeight;

	@Column(name = "f_NET_WEIGHT")
	private Double netWeight;

	@Column(name = "n_CONTAINER")
	private Long containerNo;

	@Column(name = "c_CONTAINER_TYPE", length = 100)
	private String containerType;

	@Column(name = "c_SEAL_NO", length = 100)
	private String sealNo;

	@Column(name = "c_SEAL2_NO", length = 100)
	private String seal2No;

	@Column(name = "n_BUNDLE")
	private Long noBundle;

	@Column(name = "n_PALATE")
	private Long noPalete;
}
