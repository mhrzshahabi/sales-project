package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_SHIPMENT_EMAIL")
public class ShipmentEmail extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_EMAIL")
	@SequenceGenerator(name = "SEQ_SHIPMENT_EMAIL", sequenceName = "SEQ_SHIPMENT_EMAIL")
	@Column(name = "ID", precision = 10)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", nullable = false, insertable = false, updatable = false)
	private Shipment shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@Column(name = "EMAIL_TYPE", length = 20)
	private String emailType;

	@Column(name = "STATUS", length = 20)
	private String status;

	@Column(name = "EMAIL_SUBJECT", length = 1000)
	private String emailSubject;

	@Column(name = "EMAIL_TO", length = 1000)
	private String emailTo;

	@Column(name = "EMAIL_CC", length = 1000)
	private String emailCC;

	@Column(name = "EMAIL_BODY", length = 4000)
	private String emailBody;

	@Column(name = "EMAIL_RESPOND", length = 4000)
	private String emailRespond;

}
