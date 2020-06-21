/***
 package com.nicico.sales.model.entities.base;

 import com.nicico.sales.model.entities.common.BaseEntity;
 import lombok.*;
 import lombok.experimental.Accessors;

 import javax.persistence.*;
 import javax.validation.constraints.NotNull;
 import java.util.Date;

 @Getter
 @Setter
 @NoArgsConstructor
 @AllArgsConstructor
 @Accessors(chain = true)
 @EqualsAndHashCode(of = {"id"}, callSuper = false)
 @Entity
 @Table(name = "TBL_INVOICE_EXPORT")
 public class InvoiceExport extends BaseEntity {

 @Id
 @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE_EXPORT")
 @SequenceGenerator(name = "SEQ_INVOICE_EXPORT", sequenceName = "SEQ_INVOICE_EXPORT", allocationSize = 1)
 @Column(name = "ID")
 private Long id;

 @Column(name = "d_invoice_date")
 private Date invoiceDate;

 @ManyToOne
 @Column(name = "n_shipment_id", insertable = false, updatable = false)
 private Shipment shipment;

 @NotNull
 @Column(name = "n_shipment_id")
 private Long shipmentId;

 @Column(name = 'b_is_deleted')
 private Boolean isDeleted;

 }
 **/
