package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CONTACT")
public class Contact extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTACT")
	@SequenceGenerator(name = "SEQ_CONTACT", sequenceName = "SEQ_CONTACT")
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_CODE", nullable = false,length = 100)
    private String code;

    //c_FULLNAME_FA
    @Column(name = "C_FULLNAME_FA", nullable = false, length = 1000)
    private String nameFA;

    //c_FULLNAME_EN
    @Column(name = "C_FULLNAME_EN",length = 1000)
    private String nameEN;

    //c_PHONE
    @Column(name = "C_PHONE",length = 100)
    private String phone;

    //c_MOBILE
    @Column(name = "C_MOBILE",length = 100)
    private String mobile;

    //c_FAX
    @Column(name = "C_FAX",length = 100)
    private String fax;

    //c_ADDRESS
    @Column(name = "C_ADDRESS",length = 1000)
    private String address;

    //c_WEBSITE
    @Column(name = "C_WEBSITE",length = 100)
    private String webSite;

    //c_EMAIL
    @Column(name = "C_EMAIL",length = 100)
    private String email;

    //c_TYPE
    @Column(name = "C_TYPE")
    private Boolean type;

    //c_NATIONAL_CODE
    @Column(name = "C_NATIONAL_CODE", nullable = false,length = 100)
    private String nationalCode;

    //c_ECONOMICAL_CODE
    @Column(name = "C_ECONOMICAL_CODE",length = 100)
    private String economicalCode;

    @Setter(AccessLevel.NONE)
    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "CNT_ID", insertable = false, updatable = false)
    private Set<ContactAccount> contactAccounts;

    //c_DEFAULT_BANK_ACCOUNT
    @Column(name = "C_DEFAULT_BANK_ACCOUNT",length = 100)
    private String bankAccount;

    //c_DEFAULT_BANK_SHABA
    @Column(name = "C_DEFAULT_BANK_SHABA",length = 100)
    private String bankShaba;

    //c_DEFAULT_BANK_SWIFT
    @Column(name = "C_DEFAULT_BANK_SWIFT",length = 100)
    private String bankSwift;

    //c_DEFAULT_BANK_ID
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "C_DEFAULT_BANK_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "contact2bank"))
    private Bank bank;

    //c_DEFAULT_BANK_ID
    @Column(name = "C_DEFAULT_BANK_ID")
    private Long bankId;

    @Column(name = "b_STATUS")
    private Boolean status;

    //c_TRADE_MARK
    @Column(name = "C_TRADE_MARK",length = 100)
    private String tradeMark;

    //c_COMMERCIAL_REGISTRATION
    @Column(name = "C_COMMERCIAL_REGISTRATION",length = 100)
    private String commercialRegistration;

    //c_BRANCH_NAME
    @Column(name = "C_BRANCH_NAME",length = 200)
    private String branchName;

    //c_COMMERCIAL_ROLE
    @Column(name = "C_COMMERCIAL_ROLE",length = 200)
    private String commercialRole;

    @Column(name = "b_SELLER")
    private Boolean seller;

    @Column(name = "b_BUYER")
    private Boolean buyer;

    @Column(name = "b_TRANSPORTER")
    private Boolean transporter;

    @Column(name = "b_SHIPPER")
    private Boolean shipper;

    @Column(name = "b_INSPECTOR")
    private Boolean inspector;

    @Column(name = "b_INSURANCER")
    private Boolean insurancer;

    @Column(name = "b_AGENT_BUYER")
    private Boolean agentBuyer;

    @Column(name = "b_AGENT_SELLER")
    private Boolean agentSeller;

    @Column(name = "c_CEO",length = 200)
    private String ceo;

    @Column(name = "c_CEO_PASSPORT_NO",length = 200)
    private String ceoPassportNo;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COUNTRY_ID", insertable = false, updatable = false,foreignKey = @ForeignKey(name = "contact2Country"))
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;
}
