package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.DeductionType;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

//import com.nicico.sales.model.entities.warehouse.ItemRawMaterial;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FOREIGN_INVOICE_ITEM_DETAIL")
public class ForeignInvoiceItemDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FOREIGN_INVOICE_ITEM_DETAIL")
    @SequenceGenerator(name = "SEQ_FOREIGN_INVOICE_ITEM_DETAIL", sequenceName = "SEQ_FOREIGN_INVOICE_ITEM_DETAIL", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "N_ASSAY", nullable = false, scale = 12, precision = 5)
    private BigDecimal assay;

    @NotNull
    @Column(name = "N_BASE_PRICE", nullable = false, scale = 10, precision = 2)
    private BigDecimal basePrice;

    @Column(name = "N_RC_PRICE", scale = 10, precision = 2)
    private BigDecimal rcPrice;

    @Column(name = "N_RC_BASE_PRICE", scale = 10, precision = 2)
    private BigDecimal rcBasePrice;

    @Column(name = "N_DEDUCTION_TYPE")
    private DeductionType deductionType;

    @Column(name = "N_DEDUCTION_VALUE", scale = 12, precision = 5)
    private BigDecimal deductionValue;

    @Column(name = "N_DEDUCTION_PRICE", scale = 10, precision = 2)
    private BigDecimal deductionPrice;

    // *****************************************************************************************************************

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_FOREIGN_INVOICE_ITEM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItemDetail2foreignInvoiceItemByForeignInvoiceItemId"))
    private ForeignInvoiceItem foreignInvoiceItem;

    @NotNull
    @Column(name = "F_FOREIGN_INVOICE_ITEM_ID", nullable = false)
    private Long foreignInvoiceItemId;

//    @Setter(AccessLevel.NONE)
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "F_ITEM_RAW_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItemDetail2itemRawMaterialByItemRawMaterialId"))
//    private ItemRawMaterial itemRawMaterial;
//
//    @NotNull
//    @Column(name = "F_ITEM_RAW_MATERIAL_ID", nullable = false)
//    private Long itemRawMaterialId;
}
