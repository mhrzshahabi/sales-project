package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import lombok.*;
import lombok.experimental.Accessors;
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
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_ASSAY_INSPECTION_TOTAL_VALUES")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class AssayInspectionTotalValues extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_ASSAY_INSPECTION_TOTAL_VALUES")
    @SequenceGenerator(name = "SEQ_ASSAY_INSPECTION_TOTAL_VALUES", sequenceName = "SEQ_ASSAY_INSPECTION_TOTAL_VALUES", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "N_VALUE", nullable = false, scale = 5, precision = 10)
    private BigDecimal value;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTION_REPORT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_AssayInspectionTotalValues2inspectionReportByInspectionReportId"))
    private InspectionReport inspectionReport;

    @NotNull
    @Column(name = "F_INSPECTION_REPORT_ID", nullable = false)
    private Long inspectionReportId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_AssayInspectionTotalValues2materialElementByMaterialElementId"))
    private MaterialElement materialElement;

    @NotNull
    @Column(name = "F_MATERIAL_ELEMENT_ID", nullable = false)
    private Long materialElementId;

}
