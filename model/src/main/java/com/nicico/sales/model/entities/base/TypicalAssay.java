package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_TYPICAL_ASSAY")
public class TypicalAssay extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_TBL_TYPICAL_ASSAY")
    @SequenceGenerator(name = "SEQ_TBL_TYPICAL_ASSAY", sequenceName = "SEQ_TBL_TYPICAL_ASSAY", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "N_MIN_VALUE", precision = 10, scale = 5, nullable = false)
    private BigDecimal minValue;

    @Column(name = "N_MAX_VALUE", precision = 10, scale = 5, nullable = false)
    private BigDecimal maxValue;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_typicalAssay2unitByUnitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

    @Setter
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_typicalAssay2materialElementByMaterialElementId"))
    private MaterialElement materialElement;

    @NotNull
    @Column(name = "F_MATERIAL_ELEMENT_ID", nullable = false)
    private Long materialElementId;
}

