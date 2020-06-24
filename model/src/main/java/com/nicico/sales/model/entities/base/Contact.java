package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_CONTACT",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"C_PHONE " , "b_SELLER" , "b_BUYER" , "b_TRANSPORTER" , "b_SHIPPER" , "b_INSPECTOR" , "b_INSURANCER" , "b_AGENT_BUYER" , "b_AGENT_SELLER" , "COUNTRY_ID"}, name = Contact.UNIQUE_List_Person) ,
                @UniqueConstraint(columnNames = {"C_ECONOMICAL_CODE"}, name = Contact.UNIQUE_C_ECONOMICAL_CODE) ,

        })
public class Contact extends BaseEntity {

    public static final String UNIQUE_List_Person = "UNIQUE_List_Person";
    public static final String UNIQUE_C_ECONOMICAL_CODE = "UNIQUE_C_ECONOMICAL_CODE";


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTACT")
    @SequenceGenerator(name = "SEQ_CONTACT", sequenceName = "SEQ_CONTACT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "C_FULLNAME_FA", nullable = false, length = 1000)
    private String nameFA;

    @Column(name = "C_FULLNAME_EN", length = 1000)
    private String nameEN;

    @Column(name = "C_PHONE", length = 100)
    private String phone;

    @Column(name = "C_MOBILE", length = 100)
    private String mobile;

    @Column(name = "C_FAX", length = 100)
    private String fax;

    @Column(name = "C_ADDRESS", length = 1000)
    private String address;

    @Column(name = "C_WEBSITE", length = 100)
    private String webSite;

    @Column(name = "C_EMAIL", length = 100)
    private String email;

    @Column(name = "C_TYPE")
    private Boolean type;

    @Column(name = "C_NATIONAL_CODE", length = 100)
    private String nationalCode;

    @Column(name = "C_ECONOMICAL_CODE", length = 100)
    private String economicalCode;

    @Setter(AccessLevel.NONE)
    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "CNT_ID", insertable = false, updatable = false)
    private Set<ContactAccount> contactAccounts;

    @Column(name = "C_DEFAULT_BANK_ACCOUNT", length = 100)
    private String bankAccount;

    @Column(name = "C_DEFAULT_BANK_SHABA", length = 100)
    private String bankShaba;

    @Column(name = "C_DEFAULT_BANK_SWIFT", length = 100)
    private String bankSwift;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "C_DEFAULT_BANK_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contact2bank"))
    private Bank bank;

    @Column(name = "C_DEFAULT_BANK_ID")
    private Long bankId;

    @Column(name = "b_STATUS")
    private Boolean status;

    @Column(name = "C_TRADE_MARK", length = 100)
    private String tradeMark;

    @Column(name = "C_COMMERCIAL_REGISTRATION", length = 100)
    private String commercialRegistration;

    @Column(name = "C_BRANCH_NAME", length = 200)
    private String branchName;

    @Column(name = "C_COMMERCIAL_ROLE", length = 200)
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

    @Column(name = "c_CEO", length = 200)
    private String ceo;

    @Column(name = "c_CEO_PASSPORT_NO", length = 200)
    private String ceoPassportNo;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COUNTRY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contact2Country"))
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;
}
