package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.*;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_BILL_OF_LADING_SWITCH")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class BillOfLadingSwitch extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BILL_OF_LADING_SWITCH")
    @SequenceGenerator(name = "SEQ_BILL_OF_LADING_SWITCH", sequenceName = "SEQ_BILL_OF_LADING_SWITCH", allocationSize = 1, initialValue = 100000)
    private Long id;

    @Column(name = "C_DOCUMENT_NO", unique = true)
    private String documentNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTACT_SHIPPER_EXPORTER",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LADING_SWITCH_TO_CONTACT_AS_EXPORTER"),
            insertable = false,
            updatable = false
    )
    private Contact shipperExporter;

    @Column(name = "F_CONTACT_SHIPPER_EXPORTER")
    private Long shipperExporterId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTACT_NOTIFY_PARTY",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LADING_SWITCH_TO_CONTACT_AS_NOTIFY_PARTY"),
            insertable = false,
            updatable = false
    )
    private Contact notifyParty;
    @Column(name = "F_CONTACT_NOTIFY_PARTY")
    private Long notifyPartyId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTACT_CONSIGNEE_EXPORTER",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LADING_SWITCH_TO_CONTACT_AS_CONSIGNEE"),
            insertable = false,
            updatable = false
    )
    private Contact consignee;

    @Column(name = "F_CONTACT_CONSIGNEE_EXPORTER")
    private Long consigneeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_PORT_AS_LOADING",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LADING_SWITCH_TO_PORT_AS_LOADING"),
            insertable = false,
            updatable = false
    )
    private Port portOfLoading;

    @Column(name = "F_PORT_AS_LOADING")
    private Long portOfLoadingId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_PORT_AS_DISCHARGE",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LADING_SWITCH_TO_PORT_AS_DISCHARGE"),
            insertable = false,
            updatable = false
    )
    private Port portOfDischarge;

    @Column(name = "F_PORT_AS_DISCHARGE")
    private Long portOfDischargeId;

    @OneToOne(mappedBy = "billOfLadingSwitch")
    private BillOfLanding billOfLanding;

}
