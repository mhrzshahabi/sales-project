package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_INVOICE")
public class Invoice extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE")
    @SequenceGenerator(name = "SEQ_INVOICE", sequenceName = "SEQ_INVOICE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "INVOICE2SHIPMENT"))
    private Shipment Shipment;

    @Column(name = "SHIPMENT_ID", length = 10)
    private Long shipmentId;

    @Column(name = "INVOICE_NO", length = 100)
    private String invoiceNo;

    @Column(name = "INVOIC_DATE", length = 24)
    private String invoiceDate;

    @Column(name = "INVOICE_TYPE", length = 20)
    private String invoiceType;

    @Column(name = "NET")
    private Double net;

    @Column(name = "GRASS")
    private Double grass;

    @Column(name = "UNIT_PRICE")
    private Double unitPrice;

    @Column(name = "UNIT_PRICE_CUR", length = 10)
    private String unitPriceCurrency;

    @Column(name = "INVOICE_VALUE")
    private Double invoiceValue;

    @Column(name = "INVOICE_VALUE_CUR", length = 10)
    private String invoiceValueCurrency;

    @Column(name = "PAID_PERCENT")
    private Double paidPercent;

    @Column(name = "PAID_STATUS", length = 10)
    private String paidStatus;

    @Column(name = "DEPRECIATION")
    private Double Depreciation;

    @Column(name = "OTHER_COST")
    private Double otherCost;

    @Column(name = "GOLD")
    private Double gold;

    @Column(name = "SILVER")
    private Double silver;

    @Column(name = "COPPER")
    private Double copper;

    @Column(name = "MOLYBDENUM")
    private Double molybdenum;

    @Column(name = "MOLYBDENUM_UNIT_PRICE")
    private Double molybdJenumUnitPrice;

    @Column(name = "COPPER_UNIT_PRICE")
    private Double copperUnitPrice;

    @Column(name = "SILVER_UNIT_PRICE")
    private Double silverUnitPrice;

    @Column(name = "GOLD_UNIT_PRICE")
    private Double goldUnitPrice;

    @Column(name = "PRICE_BASE")
    private String priceBase;

    @Column(name = "MOLYBDENUM_CONTENT")
    private Double molybdenumContent;

    @Column(name = "COMMERCIAL_INVOICE_VALUE")
    private Double commercialInvoceValue;

    @Column(name = "COMMERCIAL_INVOICE_VALUE_NET")
    private Double commercialInvoceValueNet;

    @Column(name = "INVOIVE_VALUE_D")
    private Double invoiceValueD;

    @Column(name = "RATE_BASE")
    private String rateBase;

    @Column(name = "RATE2DOLLAR")
    private Double rate2dollar;

    @Column(name = "INVOIVE_VALUE_UP")
    private Double invoiceValueUp;

    @Column(name = "COPPER_INS")
    private Double copperIns;

    @Column(name = "COPPER_DED")
    private Double copperDed;

    @Column(name = "COPPER_CAL")
    private Double copperCal;

    @Column(name = "SILVER_INS")
    private Double silverIns;

    @Column(name = "SILVER_DED")
    private Double silverDed;

    @Column(name = "SILVER_OZ")
    private Double silverOun;

    @Column(name = "SILVER_CAL")
    private Double silverCal;

    @Column(name = "GOLD_INS")
    private Double goldIns;

    @Column(name = "GOLD_DED")
    private Double goldDed;

    @Column(name = "GOLD_OZ")
    private Double goldOun;

    @Column(name = "GOLD_CAL")
    private Double goldCal;

    @Column(name = "SUB_TOTAL")
    private Double subTotal;

    @Column(name = "TREAT_COST")
    private Double treatCost;

    @Column(name = "RC_CU")
    private Double refinaryCostCU;

    @Column(name = "RC_CU_PER")
    private Double refinaryCostCUPer;

    @Column(name = "RC_CU_CAL")
    private Double refinaryCostCUCal;

    @Column(name = "RC_CU_TOT")
    private Double refinaryCostCUTot;

    @Column(name = "RG_AG")
    private Double refinaryCostAG;

    @Column(name = "RC_AG_PER")
    private Double refinaryCostAGPer;

    @Column(name = "RC_AG_TOT")
    private Double refinaryCostAGTot;

    @Column(name = "RC_AU")
    private Double refinaryCostAU;

    @Column(name = "RC_AU_PER")
    private Double refinaryCostAUPer;

    @Column(name = "RC_AU_TOT")
    private Double refinaryCostAUTot;

    @Column(name = "SUB_TOTAL_DEDUCTION")
    private Double subTotalDeduction;

    @Column(name = "PRICE_REFERENCE")
    private String priceReference;

    @Column(name = "PRICE_FUNCTION")
    private String priceFunction;

    @Column(name = "PRICE_FROM_DATE")
    private String priceFromDate;

    @Column(name = "PRICE_TO_DATE")
    private String priceToDate;

    @Column(name = "SELLERID")
    private Long sellerId;

    @Column(name = "BUYERID")
    private Long buyerId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SELLERID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "INVOICE2CONTACT_SELLER"))
    private Contact seller;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BUYERID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "INVOICE2CONTACT_BUYER"))
    private Contact buyer;

    @Column(name = "PROCESSID")
    private String processId;


}