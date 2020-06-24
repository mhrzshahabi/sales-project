package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.ItemElement;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_ASSAY_INSPECTION")
public class AssayInspection extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_ASSAY_INSPECTION")
    @SequenceGenerator(name = "SEQ_ASSAY_INSPECTION", sequenceName = "SEQ_ASSAY_INSPECTION", allocationSize = 1)
    private Long id;

    @Column(name = "N_VALUE", scale = 10, precision = 5)
    private BigDecimal value;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTION_REPORT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_AssayInspection2inspectionReportByInspectionReportId"))
    private InspectionReport inspectionReport;

    @NotNull
    @Column(name = "F_INSPECTION_REPORT_ID", nullable = false)
    private Long inspectionReportId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_AssayInspection2RemittanceDetailByRemittanceDetailId"))
    private RemittanceDetail remittanceDetail;

    @NotNull
    @Column(name = "F_REMITTANCE_DETAIL_ID", nullable = false)
    private Long remittanceDetailId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ITEM_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_AssayInspection2itemElementByItemElementId"))
    private ItemElement itemElement;

    @NotNull
    @Column(name = "F_ITEM_ELEMENT_ID", nullable = false)
    private Long itemElementId;

}
