package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
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
    @Column(name = "N_WEIGHT_GW", nullable = false, scale = 5, precision = 12)
    private BigDecimal weightGW;

    @NotNull
    @Column(name = "N_WEIGHT_ND", nullable = false, scale = 5, precision = 12)
    private BigDecimal weightND;

    // For molybdenum oxide, metal base price
    @NotNull
    @Column(name = "N_BASE_PRICE", nullable = false, scale = 2, precision = 10)
    private BigDecimal basePrice;

    @Column(name = "N_TC", scale = 2, precision = 10)
    private BigDecimal treatCost;

//    @Column(name = "N_DEDUCTION_TYPE")
//    private DeductionType deductionType;
//
//    @Column(name = "N_DEDUCTION_VALUE", scale = 5, precision = 12)
//    private BigDecimal deductionValue;
//
//    @Column(name = "N_DEDUCTION_UNIT_CONVERSION_RATE", scale = 5, precision = 12)
//    private BigDecimal deductionUnitConversionRate;
//
//    @Column(name = "N_DEDUCTION_PRICE", scale = 2, precision = 10)
//    private BigDecimal deductionPrice;

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
