package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.base.*;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FOREIGN_INVOICE")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ForeignInvoice extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FOREIGN_INVOICE")
    @SequenceGenerator(name = "SEQ_FOREIGN_INVOICE", sequenceName = "SEQ_FOREIGN_INVOICE", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_NO", nullable = false)
    private String no;

    @NotNull
    @Column(name = "D_DATE", nullable = false)
    private Date date;

    @NotNull
    @Column(name = "N_UNIT_PRICE", nullable = false)
    private BigDecimal unitPrice;

    @NotNull
    @Column(name = "N_UNIT_COST", nullable = false)
    private BigDecimal unitCost;

    @NotNull
    @Column(name = "N_SUM_FI_PRICE", nullable = false)
    private BigDecimal sumFIPrice;

    @NotNull
    @Column(name = "N_SUM_PI_PRICE", nullable = false)
    private BigDecimal sumPIPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE", nullable = false)
    private BigDecimal sumPrice;

    @Column(name = "D_CONVERSION_DATE")
    private Date conversionDate;

    @Column(name = "N_CONVERSION_RATE")
    private BigDecimal conversionRate;

    @Column(name = "N_CONVERSION_SUM_PRICE")
    private BigDecimal conversionSumPrice;

    @Column(name = "C_CONVERSION_SUM_PRICE_TEXT")
    private String conversionSumPriceText;

    @Column(name = "C_DESCRIPTION")
    private String description;

    @Column(name = "N_PERCENT")
    private Double percent;

    @Column(name = "F_PARENT_ID")
    private Long parentId;

    @Column(name = "N_DELAY_PENALTY")
    private BigDecimal delayPenalty;

    @Column(name = "N_PREMIUM_VALUE")
    private BigDecimal premiumValue;

    // *****************************************************************************************************************

    @Column(name = "C_DOCUMENT_ID")
    private String documentId;

    // *****************************************************************************************************************

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONVERSION_REF_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2currencyRateByConversionRefId"))
    private CurrencyRate conversionRef;

    @Column(name = "F_CONVERSION_REF_ID")
    private Long conversionRefId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CURRENCY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2unitByCurrencyId"))
    private Unit currency;

    @NotNull
    @Column(name = "F_CURRENCY_ID", nullable = false)
    private Long currencyId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_BUYER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2contactByBuyerId"))
    private Contact buyer;

    @NotNull
    @Column(name = "F_BUYER_ID", nullable = false)
    private Long buyerId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INVOICE_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2invoiceTypeByInvoiceTypeId"))
    private InvoiceType invoiceType;

    @NotNull
    @Column(name = "F_INVOICE_TYPE_ID", nullable = false)
    private Long invoiceTypeId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2shipmentByShipmentId"))
    private Shipment shipment;

    @NotNull
    @Column(name = "F_SHIPMENT_ID", nullable = false)
    private Long shipmentId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PERSON_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2employeeByCreatorId"))
    private Person creator;

    @NotNull
    @Column(name = "PERSON_ID")
    private Long creatorId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTION_WEIGHT_REPORT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2inspectionReportByInspectionWeightReportId"))
    private InspectionReport inspectionWeightReport;

    @NotNull
    @Column(name = "F_INSPECTION_WEIGHT_REPORT_ID", nullable = false)
    private Long inspectionWeightReportId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTION_ASSAY_REPORT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2inspectionReportByInspectionAssayReportId"))
    private InspectionReport inspectionAssayReport;

    @Column(name = "F_INSPECTION_ASSAY_REPORT_ID")
    private Long inspectionAssayReportId;

    // *****************************************************************************************************************

    @OneToMany(mappedBy = "foreignInvoice", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ForeignInvoiceBillOfLading> billLadings;

    @OneToMany(mappedBy = "foreignInvoice", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ForeignInvoiceItem> foreignInvoiceItems;

    @OneToMany(mappedBy = "foreignInvoice", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ForeignInvoicePayment> foreignInvoicePayments;
}
