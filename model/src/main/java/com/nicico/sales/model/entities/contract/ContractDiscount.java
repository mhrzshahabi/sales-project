package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Immutable;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Immutable
@Entity
@Table(name = "TBL_CONTRACT_DISCOUNT")
public class ContractDiscount extends BaseEntity {

    @Id
    private Long id;

    @NotNull
    @Column(name = "DISCOUNT", nullable = false, precision = 6, scale = 3)
    private BigDecimal discount;

    /*  discount contains upperBound */
    @NotNull
    @Column(name = "UPPER_BOUND", nullable = false, precision = 6, scale = 3)
    private BigDecimal upperBound;

    /*  discount does NOT contain lowerBound */
    @NotNull
    @Column(name = "LOWER_BOUND", nullable = false, precision = 6, scale = 3)
    private BigDecimal lowerBound;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDiscount2materialElementByMaterialElementId"))
    private MaterialElement materialElement;

    @NotNull
    @Column(name = "F_MATERIAL_ELEMENT_ID", nullable = false)
    private Long materialElementId;
}
