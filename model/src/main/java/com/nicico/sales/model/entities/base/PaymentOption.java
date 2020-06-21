package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_PAYMENT_OPTION")
public class PaymentOption extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PAYMENT_OPTION")
    @SequenceGenerator(name = "SEQ_PAYMENT_OPTION", sequenceName = "SEQ_PAYMENT_OPTION", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "NAME_PAY")
    private String namePay;

}
