package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.base.CurrencyRate;
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

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FOREIGN_INVOICE_PAYMENT")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ForeignInvoicePayment extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FOREIGN_INVOICE_PAYMENT")
    @SequenceGenerator(name = "SEQ_FOREIGN_INVOICE_PAYMENT", sequenceName = "SEQ_FOREIGN_INVOICE_PAYMENT", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_DOC_NO", nullable = false)
    private String docNo;

    @NotNull
    @Column(name = "D_DOC_DATE", nullable = false)
    private Date docDate;

    @NotNull
    @Column(name = "N_DOC_SUM_VALUE", nullable = false, scale = 2, precision = 14)
    private BigDecimal docSumValue;

    @Column(name = "D_DOC_CONVERSION_DATE")
    private Date docConversionDate;

    @Column(name = "N_DOC_CONVERSION_RATE", scale = 2, precision = 14)
    private BigDecimal docConversionRate;

    @Column(name = "N_DOC_CONVERSION_PRICE", scale = 2, precision = 14)
    private BigDecimal docConversionPrice;

    @Column(name = "N_PORTION", scale = 2, precision = 5)
    private BigDecimal portion;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;

    // *****************************************************************************************************************

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONVERSION_REF_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoicePayment2currencyRateByConversionRefId"))
    private CurrencyRate conversionRef;

    @Column(name = "F_CONVERSION_REF_ID")
    private Long conversionRefId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_FOREIGN_INVOICE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoicePayment2foreignInvoiceByForeignInvoiceId"))
    private ForeignInvoice foreignInvoice;

    @NotNull
    @Column(name = "F_FOREIGN_INVOICE_ID", nullable = false)
    private Long foreignInvoiceId;
}
