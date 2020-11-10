package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.CommercialRole;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CONTRACT_CONTACT")
public class ContractContact extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_CONTACT")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_CONTACT", sequenceName = "SEQ_CNTR_CONTRACT_CONTACT", allocationSize = 1)
    private Long id;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractContact2contractByContractId"))
    private Contract contract;

    @NotNull
    @Column(name = "F_CONTRACT_ID", nullable = false)
    private Long contractId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractContact2contactByContactId"))
    private Contact contact;

    @NotNull
    @Column(name = "F_CONTACT_ID", nullable = false)
    private Long contactId;

    @NotNull
    @Column(name = "N_COMMERCIAL_ROLE", nullable = false)
    private CommercialRole commercialRole;
}
