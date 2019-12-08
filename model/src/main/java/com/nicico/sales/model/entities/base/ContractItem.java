package com.nicico.sales.model.entities.base;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

/**
 * EMAMI
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CONTRACT_ITEM")
public class ContractItem {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_ITEM")
	@SequenceGenerator(name = "SEQ_CONTRACT_ITEM", sequenceName = "SEQ_CONTRACT_ITEM")
	@Column(name = "ID")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ID")
	private Contract contract;

	@Column(name = "ITEM_ROW", nullable = false, length = 20)
	private Long itemRow;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ID")
	private Material tblMaterial;

	@Column(name = "AMOUNT", nullable = false, length = 20)
	private Double amount;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UNIT_ID")
	private Unit unit;

	@Column(name = "NBL", length = 20)
	private Double nbl;

	@Column(name = "DESCL", length = 4000)
	private String descl;

	@Column(name = "IS_COMPLATE", length = 20)
	private String isComplate;

	@Column(name = "REVISORY", length = 200)
	private String revisory;

	@Column(name = "TOLORANCE")
	private Double tolorance;

	@Column(name = "OPTIONAL")
	private String optional;

	@Column(name = "PACK_SIZE")
	private Long packSize;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "RATE_ID")
	private Rate rate;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTACT_INSPECTION_ID")
	private Contact tblContactByInspection;


	@Column(name = "PRICE_REFRENCE")
	private String priceRefrence;

	@Column(name = "PLANT")
	private String plant;

}
