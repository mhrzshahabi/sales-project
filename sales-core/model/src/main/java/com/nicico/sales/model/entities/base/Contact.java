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
@Table(name = "TBL_CONTACT", schema = "SALES")
public class Contact extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTACT")
    @SequenceGenerator(name = "SEQ_CONTACT", sequenceName = "SALES.SEQ_CONTACT")
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "c_CODE", nullable = false)
    private String code;

    //c_FULLNAME_FA
    @Column(name = "C_FULLNAME_FA", nullable = false, length = 100)
    private String nameFA;

    //c_FULLNAME_EN
    @Column(name = "C_FULLNAME_EN")
    private String nameEN;

    //c_PHONE
    @Column(name = "C_PHONE")
    private String phone;

    //c_MOBILE
    @Column(name = "C_MOBILE")
    private String mobile;

    //c_FAX
    @Column(name = "C_FAX")
    private String fax;

    //c_ADDRESS
    @Column(name = "C_ADDRESS")
    private String address;

    //c_WEBSITE
    @Column(name = "C_WEBSITE")
    private String webSite;

    //c_EMAIL
    @Column(name = "C_EMAIL")
    private String email;

    //c_TYPE
    @Column(name = "C_TYPE")
    private Boolean type;

    //c_NATIONAL_CODE
    @Column(name = "C_NATIONAL_CODE", nullable = false)
    private String nationalCode;

    //c_ECONOMICAL_CODE
    @Column(name = "C_ECONOMICAL_CODE")
    private String economicalCode;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "CNT_ID", insertable = false, updatable = false)
    private Set<ContactAccount> contactAccounts;

    //c_DEFAULT_BANK_ACCOUNT
    @Column(name = "C_DEFAULT_BANK_ACCOUNT")
    private String bankAccount;

    //c_DEFAULT_BANK_SHABA
    @Column(name = "C_DEFAULT_BANK_SHABA")
    private String bankShaba;

    //c_DEFAULT_BANK_SWIFT
    @Column(name = "C_DEFAULT_BANK_SWIFT")
    private String bankSwift;

    //c_DEFAULT_BANK_ID
    // because bank is added later in contact creat form
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "C_DEFAULT_BANK_ID", nullable = false, insertable = false, updatable = false)
    private Bank bank;

    //c_DEFAULT_BANK_ID
    @Column(name = "C_DEFAULT_BANK_ID")
    private Long bankId;

    @Column(name = "b_STATUS")
    private Boolean status;

    //c_TRADE_MARK
    @Column(name = "C_TRADE_MARK")
    private String tradeMark;

    //c_COMMERCIAL_REGISTRATION
    @Column(name = "C_COMMERCIAL_REGISTRATION")
    private String commercialRegistration;

    //c_BRANCH_NAME
    @Column(name = "C_BRANCH_NAME")
    private String branchName;

    //c_COMMERCIAL_ROLE
    @Column(name = "C_COMMERCIAL_ROLE")
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

    @Column(name = "c_CEO")
    private String ceo;

    @Column(name = "c_CEO_PASSPORT_NO")
    private String ceoPassportNo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "COUNTRY_ID", insertable = false, updatable = false)
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;
}
