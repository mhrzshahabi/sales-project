package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_CONTACT_ACCOUNT")
public class ContactAccount extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTACT_ACCOUNT")
    @SequenceGenerator(name = "SEQ_CONTACT_ACCOUNT", sequenceName = "SEQ_CONTACT_ACCOUNT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "CNT_ID", nullable = false)
    private Long contactId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BANK_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "ContactAccount2bank"))
    private Bank bank;

    @Column(name = "BANK_ID")
    private Long bankId;

    @Column(name = "C_BANKCODE", nullable = false, length = 100)
    private String code;

    @Column(name = "C_BANKACCOUNT", length = 200)
    private String bankAccount;

    @Column(name = "C_BANK_SHABA", length = 100)
    private String bankShaba;

    @Column(name = "C_DEFAULT_BANK_SWIFT", length = 100)
    private String bankSwift;

    @Column(name = "C_ACCOUNT_OWNER", length = 200)
    private String accountOwner;

    @Column(name = "b_STATUS")
    private Boolean status;

    @Column(name = "b_ISDEFAULT")
    private Boolean isDefault;

}
