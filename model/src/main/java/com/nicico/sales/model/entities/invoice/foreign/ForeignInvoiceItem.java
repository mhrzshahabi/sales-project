package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FOREIGN_INVOICE_ITEM")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ForeignInvoiceItem extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FOREIGN_INVOICE_ITEM")
    @SequenceGenerator(name = "SEQ_FOREIGN_INVOICE_ITEM", sequenceName = "SEQ_FOREIGN_INVOICE_ITEM", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "N_WEIGHT_GW", nullable = false)
    private BigDecimal weightGW;

    @NotNull
    @Column(name = "N_WEIGHT_ND", nullable = false)
    private BigDecimal weightND;

    @Column(name = "N_TC")
    private BigDecimal treatCost;

    @Column(name = "N_ASSAY_MILESTONE")
    private InspectionReportMilestone assayMilestone;

    @Column(name = "N_WEIGHT_MILESTONE")
    private InspectionReportMilestone weightMilestone;

    @Column(name = "N_DEDUCTION_UNIT_CONVERSION_RATE")
    private BigDecimal deductionUnitConversionRate;

    // *****************************************************************************************************************

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_FOREIGN_INVOICE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItem2foreignInvoiceByForeignInvoiceId"))
    private ForeignInvoice foreignInvoice;

    @NotNull
    @Column(name = "F_FOREIGN_INVOICE_ID", nullable = false)
    private Long foreignInvoiceId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItem2remittanceDetailByRemittanceDetailId"))
    private RemittanceDetail remittanceDetail;

    @NotNull
    @Column(name = "F_REMITTANCE_DETAIL_ID", nullable = false)
    private Long remittanceDetailId;

    // *****************************************************************************************************************

    @OneToMany(mappedBy = "foreignInvoiceItem", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ForeignInvoiceItemDetail> foreignInvoiceItemDetails;
}
