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
@Table(name = "TBL_INVOICE_MOLYBDENUM")
public class InvoiceMolybdenum extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE")
    @SequenceGenerator(name = "SEQ_INVOICE", sequenceName = "SEQ_INVOICE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "INVOICE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "invoiceMolybdenum2invoice"))
    private Invoice invoice;

    @Column(name = "INVOICE_ID")
    private Long invoiceId;

    @Column(name = "LOT_NO", length = 100)
    private String lotNo;

    @Column(name = "NET")
    private Double net;

    @Column(name = "GRASS")
    private Double grass;

    @Column(name = "MOLYBDENUM_PERCENT")
    private Double molybdenumPercent;

    @Column(name = "COPPER_PERCENT")
    private Double copperPercent;

    @Column(name = "MOLYBDENUM_CONTENT")
    private Double molybdenumContent;

    @Column(name = "DISCOUNT_PERCENT")
    private Double discountPercent;

    @Column(name = "PRICE_FEE")
    private Double priceFee;

    @Column(name = "PRICE")
    private Double price;

}