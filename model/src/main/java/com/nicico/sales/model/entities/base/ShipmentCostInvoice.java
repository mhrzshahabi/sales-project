package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
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
@Table(name = "TBL_SHIPMENT_COST_INVOICE")
public class ShipmentCostInvoice extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_COST_INVOICE")
    @SequenceGenerator(name = "SEQ_SHIPMENT_COST_INVOICE", sequenceName = "SEQ_SHIPMENT_COST_INVOICE", allocationSize = 1)
    private Long id;

    @Column(name = "N_REFERENCE_ID")
    private Long referenceId;

    @NotNull
    @Column(name = "D_INVOICE_DATE", nullable = false)
    private Date invoiceDate;

    @NotNull
    @Column(name = "C_INVOICE_NO_PAPER", nullable = false)
    private String invoiceNoPaper;

    @NotNull
    @Column(name = "C_INVOICE_NO", nullable = false)
    private String invoiceNo;

    @NotNull
    @Column(name = "N_T_VAT", nullable = false, scale = 5, precision = 10)
    private BigDecimal tVat;

    @NotNull
    @Column(name = "N_C_VAT", nullable = false, scale = 5, precision = 10)
    private BigDecimal cVat;

    @NotNull
    @Column(name = "N_SUM_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal sumPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE_WITH_DISCOUNT", nullable = false, scale = 6, precision = 18)
    private BigDecimal sumPriceWithDiscount;

    @NotNull
    @Column(name = "N_SUM_PRICE_WITH_VAT", nullable = false, scale = 6, precision = 18)
    private BigDecimal sumPriceWithVat;

    @Column(name = "N_RIAL_PRICE", scale = 6, precision = 18)
    private BigDecimal rialPrice;

    @Column(name = "D_CONVERSION_DATE")
    private Date conversionDate;

    @NotNull
    @Column(name = "N_CONVERSION_RATE", nullable = false, scale = 5, precision = 10)
    private BigDecimal conversionRate;

    @NotNull
    @Column(name = "N_CONVERSION_SUM_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal conversionSumPrice;

    @NotNull
    @Column(name = "C_CONVERSION_SUM_PRICE_TEXT", nullable = false)
    private String conversionSumPriceText;

    @NotNull
    @Column(name = "N_BUYER_SHARE", nullable = false)
    private Double buyerShare;

    @NotNull
    @Column(name = "N_CONVERSION_SUM_PRICE_BUYER_SHARE", nullable = false, scale = 6, precision = 18)
    private BigDecimal conversionSumPriceBuyerShare;

    @NotNull
    @Column(name = "N_CONVERSION_SUM_PRICE_SELLER_SHARE", nullable = false, scale = 6, precision = 18)
    private BigDecimal conversionSumPriceSellerShare;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;

    ////// References //////

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INVOICE_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoice2invoiceTypeByInvoiceTypeId"))
    private InvoiceType invoiceType;

    @NotNull
    @Column(name = "F_INVOICE_TYPE_ID", nullable = false)
    private Long invoiceTypeId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONVERSION_REF_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoice2currencyRateByConversionRefId"))
    private CurrencyRate conversionRef;

    @Column(name = "F_CONVERSION_REF_ID")
    private Long conversionRefId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SELLER_CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoice2contactBySellerContactId"))
    private Contact sellerContact;

    @NotNull
    @Column(name = "F_SELLER_CONTACT_ID", nullable = false)
    private Long sellerContactId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_BUYER_CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoice2contactByBuyerContactId"))
    private Contact buyerContact;

    @NotNull
    @Column(name = "F_BUYER_CONTACT_ID", nullable = false)
    private Long buyerContactId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_FINANCE_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoice2unitByFinanceUnitId"))
    private Unit financeUnit;

    @NotNull
    @Column(name = "F_FINANCE_UNIT_ID", nullable = false)
    private Long financeUnitId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoice2contractByContractId"))
    private Contract contract;

    @NotNull
    @Column(name = "F_CONTRACT_ID", nullable = false)
    private Long contractId;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "shipmentCostInvoice", cascade = CascadeType.REMOVE)
    private List<ShipmentCostInvoiceDetail> shipmentCostInvoiceDetails;

}
