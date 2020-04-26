package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.DataType;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Audited
@Entity
@Table(name = "TBL_CNTR_CONTRACT_DETAIL_VALUE")
public class ContractDetailValue extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL_VALUE")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL_VALUE", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL_VALUE", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @NotEmpty
    @Column(name = "C_KEY", nullable = false)
    private String key;

    @NotNull
    @Column(name = "N_TYPE", nullable = false)
    private DataType type;

    @NotEmpty
    @Column(name = "C_VALUE", nullable = false)
    private String value;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailValue2contractDetailByContractDetailId"))
    private ContractDetail2 contractDetail;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_ID", nullable = false)
    private Long contractDetailId;
}
