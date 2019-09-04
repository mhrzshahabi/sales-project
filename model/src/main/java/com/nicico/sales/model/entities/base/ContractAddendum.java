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
@Table(name = "TBL_CONTRACT_ADDENDUM")
public class ContractAddendum extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CONTRACT_ADDENDUM_SEQ")
    @SequenceGenerator(name = "CONTRACT_ADDENDUM_SEQ", sequenceName = "SEQ_CONTRACT_ADDENDUM_SEQ",allocationSize = 1)
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "ADDENDUM_DESC", length = 1000)
    private String addendumDesc;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
    private Contract contract;

    @Column(name = "CONTRACT_ID")
    private Long contractId;
}
