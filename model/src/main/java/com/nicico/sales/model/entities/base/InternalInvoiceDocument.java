package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

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
	@Column(name = "C_INVOICE_ID")
	private String invoiceId;

	@Column(name = "C_DOCUMENT_ID")
	private String documentId;
}