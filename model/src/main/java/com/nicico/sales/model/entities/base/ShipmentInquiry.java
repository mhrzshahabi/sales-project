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
@Table(name = "TBL_SHIPMENT_INQUIRY")
public class ShipmentInquiry extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_INQUIRY")
	@SequenceGenerator(name = "SEQ_SHIPMENT_INQUIRY", sequenceName = "SEQ_SHIPMENT_INQUIRY")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_HEADER_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentHeader shipmentHeader;

	@Column(name = "SHIPMENT_HEADER_ID")
	private Long shipmentHeaderId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "RESOURCE_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentResource shipmentResource;

	@Column(name = "RESOURCE_ID")
	private Long shipmentResourceId;

	@Column(name = "DESCRIPTION", length = 1000)
	private String description;

	@Column(name = "CLOSE_DATE", length = 20)
	private String closeDate;

	@Column(name = "CREATE_DATE", length = 20)
	private String createDate;

	@Column(name = "CREATE_USER", length = 5)
	private Long createUser;

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

	@Column(name = "EMAIL_BODY")
	private String emailBody;

	@Column(name = "EMAIL_RESPOND", length = 4000)
	private String emailRespond;
}
