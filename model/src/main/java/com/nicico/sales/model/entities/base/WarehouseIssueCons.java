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
@Table(name = "TBL_WAREHOUSE_ISSUE_CONS")
public class WarehouseIssueCons extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_ISSUE")
	@SequenceGenerator(name = "SEQ_ISSUE", sequenceName = "SEQ_ISSUE")
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Warehouseissuecons2shipment"))
	private Shipment Shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@Column(name = "AMOUNT_SARCHESHMEH")
	private Double amountSarcheshmeh;

	@Column(name = "AMOUNT_MIDUK")
	private Double amountMiduk;

	@Column(name = "AMOUNT_SUNGON")
	private Double amountSungon;

	@Column(name = "TOTAL_AMOUNT")
	private Double totalAmount;

	@Column(name = "AMOUNT_DRAFT")
	private Double amountDraft;

	@Column(name = "AMOUNT_PMS")
	private Double amountPms;

}