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
@Table(name = "TBL_CONTRACT_CURRENCY")
public class ContractCurrency extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_CURRENCY")
    @SequenceGenerator(name = "SEQ_CONTRACT_CURRENCY", sequenceName = "SEQ_CONTRACT_CURRENCY", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "REFRENCE")
    private String refrence;

    @Column(name = "COEFFICIENT")
    private Long coefficient;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UNIT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "ContractCurrency2UNIT"))
    private Unit unit;

    @Column(name = "UNIT_ID")
    private Long unitId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "ContractCurrency2contract"))
    private Contract contract;

    @Column(name = "CONTRACT_ID")
    private Long contractId;

}
