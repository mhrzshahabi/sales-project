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
@Table(name = "TBL_PERSON", schema = "SALES")
public class Person extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PERSON")
	@SequenceGenerator(name = "SEQ_PERSON", sequenceName = "SALES.SEQ_PERSON")
	@Column(name = "ID", precision = 10)
	private Long id;

	//@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "CONTACT_ID", nullable = true, insertable = false, updatable = false)
	private Contact contact;

	@Column(name = "CONTACT_ID")
	private Long contactId;

	@Column(name = "FULL_NAME", nullable = false, length = 200)
	private String fullName;

	@Column(name = "JOB_TITLE", length = 200)
	private String jobTitle;

	@Column(name = "TITLE", length = 20)
	private String title;

	@Column(name = "EMAIL", nullable = false, length = 200)
	private String email;

	@Column(name = "EMAIL1", length = 200)
	private String email1;

	@Column(name = "EMAIL2", length = 200)
	private String email2;

	@Column(name = "WEB_ADDRESS", length = 200)
	private String webAddress;

	@Column(name = "PHONE_NO", length = 200)
	private String phoneNo;

	@Column(name = "FAX_NO", length = 200)
	private String faxNo;

	@Column(name = "MOBILE_NO", length = 20)
	private String mobileNo;

	@Column(name = "MOBILE_NO1", length = 20)
	private String mobileNo1;

	@Column(name = "MOBILE_NO2", length = 20)
	private String mobileNo2;

	@Column(name = "WHATSAPP", length = 200)
	private String whatsApp;

	@Column(name = "WECHAT", length = 200)
	private String weChat;

	@Column(name = "ADDRESS", length = 1000)
	private String address;
}