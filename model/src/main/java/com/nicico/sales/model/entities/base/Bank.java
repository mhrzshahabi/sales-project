package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.annotation.I18n;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@I18n
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_BANK")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class Bank extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BANK")
    @SequenceGenerator(name = "SEQ_BANK", sequenceName = "SEQ_BANK", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_NAME_FA", length = 1000)
    private String nameFA;

    @Column(name = "c_NAME_EN", length = 1000)
    private String nameEN;

    @Column(name = "c_ADDRESS", length = 1000)
    private String address;

    @Column(name = "c_CORE_BRANCH")
    private String coreBranch;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COUNTRY_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "bank2Country"))
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;

    @I18n
    @Transient
    private String name;
}
