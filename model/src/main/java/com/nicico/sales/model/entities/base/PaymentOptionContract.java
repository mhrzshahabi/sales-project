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
@Table(name = "TBL_CONTRACT_PAYMENT_OPTION")
public class PaymentOptionContract extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_PAYMENT_OPTION")
	@SequenceGenerator(name = "SEQ_CONTRACT_PAYMENT_OPTION", sequenceName = "SEQ_CONTRACT_PAYMENT_OPTION")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
	private Contract contract;

	@Column(name = "CONTRACT_ID")
	private Long contractId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PAYMENT_OPTION_ID", nullable = false, insertable = false, updatable = false)
	private PaymentOption paymentOption;

	@Column(name = "PAYMENT_OPTION_ID")
	private Long paymentOptionId;

}
