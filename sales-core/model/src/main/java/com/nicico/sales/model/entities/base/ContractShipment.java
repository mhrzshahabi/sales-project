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
@Table(name = "TBL_CONTRACT_SHIPMENT", schema = "SALES")
public class ContractShipment extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_SHIPMENT")
	@SequenceGenerator(name = "SEQ_CONTRACT_SHIPMENT", sequenceName = "SALES.SEQ_CONTRACT_SHIPMENT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
	private Contract contract;

	@Column(name = "CONTRACT_ID")
	private Long contractId;

	@Column(name = "PLAN", length = 20)
	private String plan;

	@Column(name = "SHIPMENT_ROW", length = 5)
	private Long shipmentRow;

	@ManyToOne
	@JoinColumn(name = "DISCHARGE", nullable = false, insertable = false, updatable = false)
	private Port discharge;

	@Column(name = "DISCHARGE")
	private Long dischargeId;

	@Column(name = "ADDRESS", length = 4000)
	private String address;

	@Column(name = "AMOUNT")
	private Double amount;

	@Column(name = "SEND_DATE", length = 20)
	private String sendDate;

	@Column(name = "DURATION")
	private Long duration;

	@Column(name = "TOLORANCE")
	private Long tolorance;

}
