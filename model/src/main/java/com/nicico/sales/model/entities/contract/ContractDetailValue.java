package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.DataType;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CONTRACT_DETAIL_VALUE")
@Audited
@AuditOverride(forClass = BaseEntity.class)
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

    // TODO Drop it ...
    @NotEmpty
    @Column(name = "C_TITLE", nullable = false)
    private String title;

    @NotNull
    @Column(name = "N_TYPE", nullable = false)
    private DataType type;

    @Column(name = "C_REFERENCE")
    private String reference;

    @Column(name = "B_REQUIRED", nullable = false)
    private Boolean required;

    @Column(name = "C_VALUE")
    private String value;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailValue2unitByUnitId"))
    private Unit unit;

    @Column(name = "F_UNIT_ID")
    private Long unitId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailValue2contractDetailByContractDetailId"))
    private ContractDetail contractDetail;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_ID", nullable = false)
    private Long contractDetailId;

    @OneToOne(mappedBy = "contractDetailValue", fetch = FetchType.LAZY)
    private CDTPDynamicTableValue cdtpDynamicTableValue;
}
