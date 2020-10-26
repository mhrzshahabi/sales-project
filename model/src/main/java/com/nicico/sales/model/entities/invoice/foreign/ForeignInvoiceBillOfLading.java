package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FOREIGN_INVOICE_BILL_OF_LANDING")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ForeignInvoiceBillOfLading extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FOREIGN_INVOICE_BILL_OF_LANDING")
    @SequenceGenerator(name = "SEQ_FOREIGN_INVOICE_BILL_OF_LANDING", sequenceName = "SEQ_FOREIGN_INVOICE_BILL_OF_LANDING", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_FOREIGN_INVOICE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceBillOfLanding2foreignInvoiceByForeignInvoiceId"))
    private ForeignInvoice foreignInvoice;

    @NotNull
    @Column(name = "F_FOREIGN_INVOICE_ID", nullable = false)
    private Long foreignInvoiceId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_BILL_OF_LANDING_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceBillOfLanding2billOfLandingByBillOfLandingId"))
    private BillOfLanding billOfLanding;

    @NotNull
    @Column(name = "F_BILL_OF_LANDING_ID", nullable = false)
    private Long billOfLandingId;
}
