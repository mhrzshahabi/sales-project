package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_DEDUCTION")
public class Deduction extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_TBL_DEDUCTION")
    @SequenceGenerator(name = "SEQ_TBL_DEDUCTION", sequenceName = "SEQ_TBL_DEDUCTION", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "N_TREATMENT_COST", precision = 10, scale = 5, nullable = false)
    private BigDecimal treatmentCost;

    @Column(name = "N_REFINERY_COST", precision = 10, scale = 5, nullable = false)
    private BigDecimal refineryCost;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_deduction2unitByUnitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

    @Setter
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_deduction2materialElementByMaterialElementId"))
    private MaterialElement materialElement;

    @NotNull
    @Column(name = "F_MATERIAL_ELEMENT_ID", nullable = false)
    private Long materialElementId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "FK_DEDUCTION2CONTRACT2BYCONTRACTID"))
    private Contract contract;

    @NotNull
    @Column(name = "F_CONTRACT_ID", nullable = false)
    private Long contractId;
}

