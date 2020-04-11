package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.base.Contract;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Audited
@Entity
@Table(name = "TBL_CNTR_CONTRACT_DETAIL")
public class ContractDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL", allocationSize = 1)
    private Long id;

    @Column(name = "C_CONTENT")
    private String content;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetail2contractByContractId"))
    private Contract contract;

    @NotNull
    @Column(name = "F_CONTRACT_ID", nullable = false)
    private Long contractId;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetail2contractDetailTypeByContractDetailTypeId"))
    private Contract contractDetailType;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_TYPE_ID", nullable = false)
    private Long contractDetailTypeId;

    @NotAudited
    @OneToMany(mappedBy = "contractDetail", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<ContractDetailValue> contractDetailValues;
}