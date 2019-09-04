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
@Table(name = "TBL_CONTRACT_CURRENCY")
public class ContractCurrency extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CONTRACT_CURRENCY_SEQ")
    @SequenceGenerator(name = "CONTRACT_CURRENCY", sequenceName = "SEQ_CONTRACT_CURRENCY_ID",allocationSize = 1)
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "REFRENCE")
    private String refrence;

    @Column(name = "COEFFICIENT")
    private Long coefficient;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CURRENCY_ID", nullable = false, insertable = false, updatable = false)
    private Currency tblCurrency;

    @Column(name = "CURRENCY_ID")
    private Long currencyId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
    private Contract contract;

    @Column(name = "CONTRACT_ID")
    private Long contractId;
}
