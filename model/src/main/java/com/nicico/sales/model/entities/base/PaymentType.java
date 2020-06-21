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
@Table(name = "TBL_PAYMENT_TYPE")
public class PaymentType extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PAYMENT_TYPE")
    @SequenceGenerator(name = "SEQ_PAYMENT_TYPE", sequenceName = "SEQ_PAYMENT_TYPE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "PAYMENT_CODE")
    private Long code;

    @Column(name = "PAYMENT_TYPE")
    private String paymentType;

    @Column(name = "PAYMENT_NON_CASH")
    private Boolean nonCash;

}
