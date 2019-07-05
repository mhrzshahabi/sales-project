package com.nicico.sales.model.entities.base;

import javax.persistence.*;

/**
 * EMAMI
 */
@Entity
@Table(name = "TBL_CONTRACT_ITEM", schema = "SALES")
public class ContractItem {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_ITEM")
	@SequenceGenerator(name = "SEQ_CONTRACT_ITEM", sequenceName = "SALES.SEQ_CONTRACT_ITEM")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "CONTRACT_ID")
	private Contract contract;

	@Column(name = "ITEM_ROW", nullable = false, length = 20)
	private Long itemRow;

	@ManyToOne
	@JoinColumn(name = "MATERIAL_ID")
	private Material tblMaterial;

	@Column(name = "AMOUNT", nullable = false, length = 20)
	private Double amount;

	@ManyToOne
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

	@ManyToOne
	@JoinColumn(name = "RATE_ID")
	private Rate rate;

	@ManyToOne
	@JoinColumn(name = "CONTACT_INSPECTION_ID")
	private Contact tblContactByInspection;


	@Column(name = "PRICE_REFRENCE")
	private String priceRefrence;

	@Column(name = "PLANT")
	private String plant;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public String getIsComplate() {
		return isComplate;
	}

	public void setIsComplate(String isComplate) {
		this.isComplate = isComplate;
	}

	public Long getItemRow() {
		return itemRow;
	}

	public void setItemRow(Long itemRow) {
		this.itemRow = itemRow;
	}

	public Material getTblMaterial() {
		return tblMaterial;
	}

	public void setTblMaterial(Material tblMaterial) {
		this.tblMaterial = tblMaterial;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	public Double getNbl() {
		return nbl;
	}

	public void setNbl(Double nbl) {
		this.nbl = nbl;
	}

	public String getDescl() {
		return descl;
	}

	public void setDescl(String descl) {
		this.descl = descl;
	}

	public String getRevisory() {
		return revisory;
	}

	public void setRevisory(String revisory) {
		this.revisory = revisory;
	}

	public Double getTolorance() {
		return tolorance;
	}

	public void setTolorance(Double tolorance) {
		this.tolorance = tolorance;
	}

	public Rate getRate() {
		return rate;
	}

	public void setRate(Rate rate) {
		this.rate = rate;
	}

	public String getOptional() {
		return optional;
	}

	public void setOptional(String option) {
		this.optional = optional;
	}

	public Contact getTblContactByInspection() {
		return tblContactByInspection;
	}

	public void setTblContactByInspection(Contact tblContactByInspection) {
		this.tblContactByInspection = tblContactByInspection;
	}

	public Long getPackSize() {
		return packSize;
	}

	public void setPackSize(Long packSize) {
		this.packSize = packSize;
	}

	public String getPlant() {
		return plant;
	}

	public void setPlant(String plant) {
		this.plant = plant;
	}

	public String getPriceRefrence() {
		return priceRefrence;
	}

	public void setPriceRefrence(String priceRefrence) {
		this.priceRefrence = priceRefrence;
	}
}
