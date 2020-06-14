package com.nicico.sales.model.entities.invoice.foreign;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

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

    // *****************************************************************************************************************

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FOREIGN_INVOICE_ITEM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItemDetail2foreignInvoiceItemByForeignInvoiceItemId"))
    private ForeignInvoiceItem foreignInvoiceItem;

    @NotNull
    @Column(name = "FOREIGN_INVOICE_ITEM_ID")
    private Long foreignInvoiceItemId;
}
