package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
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
public class ContractDetail2 extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL", allocationSize = 1)
    private Long id;

    @Column(name = "C_CONTENT", columnDefinition = "TEXT")
    @Lob
    private String content;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetail2contractByContractId"))
    private Contract2 contract;

    @NotNull
    @Column(name = "F_CONTRACT_ID", nullable = false)
    private Long contractId;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetail2contractDetailTypeByContractDetailTypeId"))
    private ContractDetailType contractDetailType;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_TYPE_ID", nullable = false)
    private Long contractDetailTypeId;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_TYPE_TEMPLATE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetail2contractDetailTypeTemplateByContractDetailTypeTemplateId"))
    private ContractDetailTypeTemplate contractDetailTypeTemplate;

    @Column(name = "F_CONTRACT_DETAIL_TYPE_TEMPLATE_ID")
    private Long contractDetailTypeTemplateId;

    @NotAudited
    @OneToMany(mappedBy = "contractDetail", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ContractDetailValue> contractDetailValues;
}
