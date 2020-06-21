package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_INVOICEINTERNALDOCUMENT")
public class InvoiceInternalDocument extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "seq_invoice_internal_document")
    @SequenceGenerator(name = "seq_invoice_internal_document", sequenceName = "seq_invoice_internal_document", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "INV_ID", length = 10)
    private String invId;

    @Column(name = "PROCESSID")
    private String processId;


}