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
@Table(name = "TBL_CONTRACT_ITEM_SHIPMENT")
public class ContractItemShipment extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_ITEM_SHIPMENT")
	@SequenceGenerator(name = "SEQ_CONTRACT_ITEM_SHIPMENT", sequenceName = "SEQ_CONTRACT_ITEM_SHIPMENT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ITEM_ID")
	private ContractItem contractItem;

	@Column(name = "CONTRACT_ITEM_ID", nullable = false, insertable = false, updatable = false)
	private Long contractItemId;

	@Column(name = "PLAN", nullable = false, length = 20)
	private String plan;

	@Column(name = "SHIPMENT_ROW", nullable = false, length = 5)
	private Long shipmentRow;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "DISCHARGE")
	private Port port;

	@Column(name = "DISCHARGE", nullable = false, insertable = false, updatable = false)
	private Long portId;

	@Column(name = "ADDRESS", nullable = false, length = 4000)
	private String address;

	@Column(name = "AMOUNT")
	private Double amount;

	@Column(name = "SEND_DATE", nullable = false, length = 20)
	private String sendDate;

	@Column(name = "DURATION")
	private Long duration;

	@Column(name = "TOLORANCE")
	private Long tolorance;

}
