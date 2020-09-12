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
@EqualsAndHashCode(of = {"invoiceId"}, callSuper = false)
@Entity
@Table(name = "TBL_INTERNAL_INVOICE_DOCUMENT")
public class InternalInvoiceDocument extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INTERNAL_INVOICE_DOCUMENT")
	@SequenceGenerator(name = "SEQ_INTERNAL_INVOICE_DOCUMENT", sequenceName = "SEQ_INTERNAL_INVOICE_DOCUMENT", allocationSize = 1)
	@Column(name = "C_INVOICE_ID")
	private String invoiceId;

	@Column(name = "C_DOCUMENT_ID")
	private String documentId;
}