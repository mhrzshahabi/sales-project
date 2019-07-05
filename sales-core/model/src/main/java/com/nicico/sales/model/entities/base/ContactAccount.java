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
@Table(name = "TBL_CONTACT_ACCOUNT", schema = "SALES")
public class ContactAccount extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTACT_ACCOUNT")
	@SequenceGenerator(name = "SEQ_CONTACT_ACCOUNT", sequenceName = "SALES.SEQ_CONTACT_ACCOUNT")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "CNT_ID", nullable = false)
	private Long contactId;

	//because bank is show in contactAccount gridList
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "BANK_ID", insertable = false, updatable = false)
	private Bank bank;

	@Column(name = "BANK_ID")
	private Long bankId;

	//c_BANKCODE
	@Column(name = "C_BANKCODE", nullable = false)
	private String code;

	//c_BANKACCOUNT
	@Column(name = "C_BANKACCOUNT")
	private String bankAccount;

	//c_BANK_SHABA
	@Column(name = "C_BANK_SHABA")
	private String bankShaba;

	//c_DEFAULT_BANK_SWIFT
	@Column(name = "C_DEFAULT_BANK_SWIFT")
	private String bankSwift;

	//c_ACCOUNT_OWNER
	@Column(name = "C_ACCOUNT_OWNER")
	private String accountOwner;

	@Column(name = "b_STATUS")
	private Boolean status;

	@Column(name = "b_ISDEFAULT")
	private Boolean isDefault;
}
