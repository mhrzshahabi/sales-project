package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.model.enumeration.DeductionType;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FOREIGN_INVOICE_ITEM")
public class ForeignInvoiceItem extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FOREIGN_INVOICE_ITEM")
    @SequenceGenerator(name = "SEQ_FOREIGN_INVOICE_ITEM", sequenceName = "SEQ_FOREIGN_INVOICE_ITEM", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "N_WEIGHT_GW", nullable = false, scale = 12, precision = 5)
    private BigDecimal weightGW;

    @NotNull
    @Column(name = "N_WEIGHT_ND", nullable = false, scale = 12, precision = 5)
    private BigDecimal weightND;

    @NotNull
    @Column(name = "N_BASE_PRICE", nullable = false, scale = 10, precision = 2)
    private BigDecimal basePrice;

    @Column(name = "N_TC", scale = 10, precision = 2)
    private BigDecimal treatCost;

    @Column(name = "N_DEDUCTION_TYPE")
    private DeductionType deductionType;

    @Column(name = "N_DEDUCTION_VALUE", scale = 12, precision = 5)
    private BigDecimal deductionValue;

    @Column(name = "N_DEDUCTION_PRICE", scale = 10, precision = 2)
    private BigDecimal deductionPrice;

    // *****************************************************************************************************************

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_FOREIGN_INVOICE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItem2foreignInvoiceByForeignInvoiceId"))
    private ForeignInvoice foreignInvoice;

    @NotNull
    @Column(name = "F_FOREIGN_INVOICE_ID", nullable = false)
    private Long foreignInvoiceId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItem2remittanceDetailByRemittanceDetailId"))
    private RemittanceDetail remittanceDetail;

    @NotNull
    @Column(name = "F_REMITTANCE_DETAIL_ID", nullable = false)
    private Long remittanceDetailId;
}
