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
@Table(name = "TBL_INVOICE_FOREIGN")
public class Invoice extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE_FOREIGN")
    @SequenceGenerator(name = "SEQ_INVOICE_FOREIGN", sequenceName = "SEQ_INVOICE_FOREIGN", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "INVOICE2SHIPMENT"))
    private Shipment Shipment;

    @Column(name = "SHIPMENT_ID")
    private Long shipmentId;

    @Column(name = "INVOICE_NO")
    private String invoiceNo;

    @Column(name = "INVOIC_DATE")
    private String invoiceDate;

    @Column(name = "INVOICE_TYPE")
    private String invoiceType;

    @Column(name = "NET")
    private Double net;

    @Column(name = "GROSS")
    private Double gross;

    @Column(name = "UNIT_PRICE")
    private Double unitPrice;

    @Column(name = "UNIT_PRICE_CUR")
    private String unitPriceCurrency;

    @Column(name = "INVOICE_VALUE")
    private Double invoiceValue;

    @Column(name = "INVOICE_VALUE_CUR")
    private String invoiceValueCurrency;

    @Column(name = "PAID_PERCENT")
    private Double paidPercent;

    @Column(name = "PAID_STATUS")
    private String paidStatus;

    @Column(name = "GOLD")
    private Double gold;

    @Column(name = "SILVER")
    private Double silver;

    @Column(name = "COPPER")
    private Double copper;

    @Column(name = "MOLYBDENUM")
    private Double molybdenum;

    @Column(name = "MOLYBDENUM_UNIT_PRICE")
    private Double molybdenumUnitPrice;

    @Column(name = "COPPER_UNIT_PRICE")
    private Double copperUnitPrice;

    @Column(name = "SILVER_UNIT_PRICE")
    private Double silverUnitPrice;

    @Column(name = "GOLD_UNIT_PRICE")
    private Double goldUnitPrice;

    @Column(name = "TREAT_COST")
    private Double treatCost;

    @Column(name = "RC_CU")
    private Double refineryCostCU;

    @Column(name = "RC_AG")
    private Double refineryCostAG;

    @Column(name = "RC_AU")
    private Double refineryCostAU;

    @Column(name = "PROCESS_ID")
    private String processId;

}
