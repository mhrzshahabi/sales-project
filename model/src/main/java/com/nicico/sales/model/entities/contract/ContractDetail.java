package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CONTRACT_DETAIL",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"F_CONTRACT_ID","F_CONTRACT_DETAIL_TYPE_ID"}, name = "UC_F_CONTRACT_ID_DETAIL_TYPE_ID"),
        })
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ContractDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL", allocationSize = 1)
    private Long id;

    @Column(name = "C_CONTENT", columnDefinition = "TEXT")
    @Lob
    private String content;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetail2contractByContractId"))
    private Contract contract;

    @NotNull
    @Column(name = "F_CONTRACT_ID", nullable = false)
    private Long contractId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetail2contractDetailTypeByContractDetailTypeId"))
    private ContractDetailType contractDetailType;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_TYPE_ID", nullable = false)
    private Long contractDetailTypeId;

    @Column(name = "C_CONTRACT_DETAIL_TEMPLATE")
    @Lob
    private String contractDetailTemplate;

    @OneToMany(mappedBy = "contractDetail", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ContractDetailValue> contractDetailValues;

    @NotNull
    @Column(name = "N_POSITION", nullable = false)
    private Integer position;
}
