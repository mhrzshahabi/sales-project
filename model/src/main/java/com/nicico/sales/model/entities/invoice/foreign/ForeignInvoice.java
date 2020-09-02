package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.base.*;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FOREIGN_INVOICE")
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
    @Column(name = "N_UNIT_PRICE", nullable = false, scale = 2, precision = 10)
    private BigDecimal unitPrice;

    @NotNull
    @Column(name = "N_UNIT_COST", nullable = false, scale = 2, precision = 10)
    private BigDecimal unitCost;

    @NotNull
    @Column(name = "N_SUM_FI_PRICE", nullable = false, scale = 2, precision = 14)
    private BigDecimal sumFIPrice;

    @NotNull
    @Column(name = "N_SUM_PI_PRICE", nullable = false, scale = 2, precision = 14)
    private BigDecimal sumPIPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE", nullable = false, scale = 2, precision = 14)
    private BigDecimal sumPrice;

    @Column(name = "D_CONVERSION_DATE")
    private Date conversionDate;

    @Column(name = "N_CONVERSION_RATE", scale = 5, precision = 12)
    private BigDecimal conversionRate;

    @Column(name = "N_CONVERSION_SUM_PRICE", scale = 2, precision = 19)
    private BigDecimal conversionSumPrice;

    @Column(name = "C_CONVERSION_SUM_PRICE_TEXT")
    private String conversionSumPriceText;

    @Column(name = "C_DESCRIPTION")
    private String description;

    // *****************************************************************************************************************

    @Column(name = "N_ACCOUNTING_ID")
    private Long accountingId;

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

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PERSON_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoice2employeeByCreatorId"))
    private Person creator;

    @NotNull
    @Column(name = "PERSON_ID")
    private Long creatorId;

    // *****************************************************************************************************************

    @OneToMany(mappedBy = "foreignInvoice", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ForeignInvoiceBillOfLading> billLadings;

    @OneToMany(mappedBy = "foreignInvoice", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ForeignInvoiceItem> foreignInvoiceItems;

    @OneToMany(mappedBy = "foreignInvoice", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ForeignInvoicePayment> foreignInvoicePayments;
}
