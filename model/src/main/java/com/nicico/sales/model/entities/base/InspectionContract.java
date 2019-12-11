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
@Table(name = "TBL_INSPECTION_CONTRACT")
public class InspectionContract extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INSPECTION_CONTRACT")
	@SequenceGenerator(name = "SEQ_INSPECTION_CONTRACT", sequenceName = "SEQ_INSPECTION_CONTRACT")
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "SHIPMENT_ID", nullable = false, insertable = false, updatable = false)
	private Shipment shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INSPECTION_CONTACT_ID", nullable = false, insertable = false, updatable = false)
	private Contact contactByInspection;

	@Column(name = "INSPECTION_CONTACT_ID")
	private Long contactByInspectionId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_CONTRACT_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentContract shipmentContract;

	@Column(name = "SHIPMENT_CONTRACT_ID")
	private Long shipmentContractId;

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

	@Column(name = "EMAIL_BODY", length = 4000)
	private String emailBody;

	@Column(name = "EMAIL_RESPOND", length = 4000)
	private String emailRespond;


	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTACT_ID", insertable = false, updatable = false)
	private Contact contact;
	@Column(name = "CONTACT_ID")
	private Long contactId;

   /* @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "LOAD_PORT")
    private TblPort tblPortByLoadPort;*/

    /*@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DISCHARGE_PORT")
    private TblPort tblPortByDischargePort;*/

	@Column(name = "VESSEL_NAME", length = 1000)
	private String vesselName;

	@Column(name = "SUPERVISER_WEIGHING", length = 20)
	private Boolean superviseWeighing;

	@Column(name = "SAMPLING", length = 20)
	private Boolean sampling;

	@Column(name = "MOISTURE_DETERMINATION", length = 20)
	private Boolean moistureDetermination;
}
