package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.Audited;

import javax.persistence.*;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CONTACT_ACCOUNT",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"C_BANK_ACCOUNT"}, name = ContactAccount.UNIQUE_C_BANK_ACCOUNT),
        })
public class ContactAccount extends BaseEntity {

    public static final String UNIQUE_C_BANK_ACCOUNT = "UNIQUE_C_BANK_ACCOUNT";

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTACT_ACCOUNT")
    @SequenceGenerator(name = "SEQ_CONTACT_ACCOUNT", sequenceName = "SEQ_CONTACT_ACCOUNT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Audited(targetAuditMode = NOT_AUDITED)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CNT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "ContactAccount2Contact"))
    private Contact contact;

    @Column(name = "CNT_ID", nullable = false)
    private Long contactId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BANK_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "ContactAccount2bank"))
    private Bank bank;

    @Column(name = "BANK_ID")
    private Long bankId;

    @Column(name = "C_BANKCODE", nullable = false)
    private String code;

    @Column(name = "C_BANK_ACCOUNT")
    private String bankAccount;

    @Column(name = "C_BANK_SHABA")
    private String bankShaba;

    @Column(name = "C_DEFAULT_BANK_SWIFT")
    private String bankSwift;

    @Column(name = "C_ACCOUNT_OWNER")
    private String accountOwner;

    @Column(name = "b_STATUS")
    private Boolean status;

    @Column(name = "b_ISDEFAULT")
    private Boolean isDefault;

}
