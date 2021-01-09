package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Immutable;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id", "discount", "upperBound", "lowerBound", "materialElementId", "contractId"}, callSuper = false)
@Immutable
@Entity
@Table(name = "TBL_CONTRACT_DISCOUNT")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ContractDiscount extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_TBL_CONTRACT_DISCOUNT")
    @SequenceGenerator(name = "SEQ_TBL_CONTRACT_DISCOUNT", sequenceName = "SEQ_TBL_CONTRACT_DISCOUNT", allocationSize = 1)
    @Column(name = "ID")
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

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDiscount2materialElementByMaterialElementId"))
    private MaterialElement materialElement;

    @NotNull
    @Column(name = "F_MATERIAL_ELEMENT_ID", nullable = false)
    private Long materialElementId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "FK_DIDSCOUNT2CONTRACT2BYCONTRACTID"))
    private Contract contract;

    @NotNull
    @Column(name = "F_CONTRACT_ID", nullable = false)
    private Long contractId;
}
