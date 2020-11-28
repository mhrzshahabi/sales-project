package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.DataType;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CONTRACT_DETAIL_TYPE_PARAM",
        uniqueConstraints = @UniqueConstraint(columnNames = {"C_KEY", "F_CONTRACT_DETAIL_TYPE_ID"}, name = "UC_C_KEY_F_CONTRACT_DETAIL_TYPE_ID"))
public class ContractDetailTypeParam extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_PARAM")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_PARAM", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_PARAM", allocationSize = 1)
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

    @Column(name = "C_REFERENCE")
    private String reference;

    @Column(name = "C_DEFAULT_VALUE", length = 4000)
    private String defaultValue;

    @Column(name = "B_REQUIRED")
    private Boolean required;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailTypeParam2unitByUnitId"))
    private Unit unit;

    @Column(name = "F_UNIT_ID")
    private Long unitId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailTypeParam2contractDetailTypeByContractDetailTypeId"))
    private ContractDetailType contractDetailType;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_TYPE_ID", nullable = false)
    private Long contractDetailTypeId;

    @Setter(AccessLevel.NONE)
    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.REMOVE, mappedBy = "cdtp")
    private Set<CDTPDynamicTable> dynamicTables;
}
