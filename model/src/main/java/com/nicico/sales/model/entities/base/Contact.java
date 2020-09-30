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
                @UniqueConstraint(columnNames = {"C_PHONE ", "b_SELLER", "b_BUYER", "b_TRANSPORTER", "b_SHIPPER", "b_INSPECTOR", "b_INSURANCER", "b_AGENT_BUYER", "b_AGENT_SELLER", "COUNTRY_ID"}, name = Contact.UNIQUE_List_Person),
                @UniqueConstraint(columnNames = {"C_ECONOMICAL_CODE"}, name = Contact.UNIQUE_C_ECONOMICAL_CODE),

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

    @Column(name = "C_PHONE")
    private String phone;

    @Column(name = "C_MOBILE")
    private String mobile;

    @Column(name = "C_FAX")
    private String fax;

    @Column(name = "C_ADDRESS", length = 1000)
    private String address;

    @Column(name = "C_WEBSITE")
    private String webSite;

    @Column(name = "C_EMAIL")
    private String email;

    @Column(name = "C_TYPE")
    private Boolean type;

    @Column(name = "C_NATIONAL_CODE")
    private String nationalCode;

    @Column(name = "C_ECONOMICAL_CODE")
    private String economicalCode;

    @Setter(AccessLevel.NONE)
    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "CNT_ID", insertable = false, updatable = false)
    private Set<ContactAccount> contactAccounts;

    @Column(name = "b_STATUS")
    private Boolean status;

    @Column(name = "C_TRADE_MARK")
    private String tradeMark;

    @Column(name = "C_COMMERCIAL_REGISTRATION")
    private String commercialRegistration;

    @Column(name = "C_BRANCH_NAME")
    private String branchName;

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

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COUNTRY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contact2Country"))
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;

    @Column(name = "C_POSTAL_CODE")
    private String postalCode;

    @Column(name = "C_REGISTER_NUMBER")
    private String registerNumber;

    @Column(name = "C_ACC_DETAIL")
    private String accDetail;

    @Column(name = "C_ACC_DETAIL_ID")
    private Long accDetailId;

    @Transient
    public ContactAccount getDefaultAccount() {
        if (contactAccounts != null && !contactAccounts.isEmpty()) {
            return contactAccounts.stream().filter(ContactAccount::getIsDefault).findAny().orElse(null);
        }
        return null;
    }
}
