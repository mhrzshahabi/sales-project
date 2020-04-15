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
@Table(name = "TBL_INVOICE_SALES_ITEM")
public class InvoiceSalesItem extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE_SALES_ITEM")
    @SequenceGenerator(name = "SEQ_INVOICE_SALES_ITEM", sequenceName = "SEQ_INVOICE_SALES_ITEM", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "PRODUCT_CODE")
    private String productCode;

    @Column(name = "PRODUCT_NAME")
    private String productName;

    @Column(name = "UNIT_NAME")
    private String unitName;

    @Column(name = "NET_AMOUNT")
    private Double netAmount;

    @Column(name = "ORDER_AMOUNT")
    private Double orderAmount;

    @Column(name = "UNIT_PRICE")
    private Double unitPrice;

    @Column(name = "LINE_PRICE")
    private Double linePrice;

    @Column(name = "DISCOUNT")
    private Double discount;

    @Column(name = "LINE_PRICE_AFTER_DISCOUNT")
    private Double linePriceAfterDiscount;

    @Column(name = "LEGAL_FEES")
    private Double legalFees;

    @Column(name = "VAT")
    private Double vat;

    @Column(name = "TOTAL_PRICE")
    private Double totalPrice;

    @Column(name = "NOTES")
    private String notes;

    @Column(name = "EXPLAIN")
    private String explain;




}
