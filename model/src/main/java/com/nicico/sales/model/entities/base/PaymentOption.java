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
@Table(name = "TBL_PAYMENT_OPTION", schema = "SALES")
public class PaymentOption extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PAYMENT_OPTION")
	@SequenceGenerator(name = "SEQ_PAYMENT_OPTION", sequenceName = "SALES.SEQ_PAYMENT_OPTION")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "NAME_PAY")
	private String namePay;

}