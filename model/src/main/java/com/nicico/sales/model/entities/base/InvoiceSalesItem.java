package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_INVOICE_SALES_ITEM")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class InvoiceSalesItem extends BaseEntity {

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
    private Long orderAmount;

    @Column(name = "UNIT_PRICE")
    private Long unitPrice;

    @Column(name = "LINE_PRICE")
    private Long linePrice;

    @Column(name = "DISCOUNT")
    private Long discount;

    @Column(name = "LINE_PRICE_AFTER_DISCOUNT")
    private Long linePriceAfterDiscount;

    @Column(name = "LEGAL_FEES")
    private Long legalFees;

    @Column(name = "VAT")
    private Long vat;

    @Column(name = "TOTAL_PRICE")
    private Long totalPrice;

    @Column(name = "NOTES")
    private String notes;

    @Column(name = "EXPLAIN")
    private String explain;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "INVOICE_SALES_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "invoicesales_itm2invoicesales"))
    private InvoiceSales invoiceSales;

    @Column(name = "INVOICE_SALES_ID")
    private Long invoiceSalesId;


}
