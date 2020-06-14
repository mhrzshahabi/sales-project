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
@Table(name = "TBL_FOREIGN_INVOICE_ITEM")
public class ForeignInvoiceItem extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FOREIGN_INVOICE_ITEM")
    @SequenceGenerator(name = "SEQ_FOREIGN_INVOICE_ITEM", sequenceName = "SEQ_FOREIGN_INVOICE_ITEM", allocationSize = 1)
    private Long id;

    // *****************************************************************************************************************

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FOREIGN_INVOICE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_foreignInvoiceItem2foreignInvoiceByForeignInvoiceId"))
    private ForeignInvoice foreignInvoice;

    @NotNull
    @Column(name = "FOREIGN_INVOICE_ID")
    private Long foreignInvoiceId;
}
