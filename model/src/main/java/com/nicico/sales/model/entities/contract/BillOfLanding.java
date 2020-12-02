package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.*;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

//بارنامه
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_BILL_OF_LANDING")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class BillOfLanding extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BILL_OF_LANDING")
    @SequenceGenerator(name = "SEQ__BILL_OF_LANDING", sequenceName = "SEQ_CNTR_BILL_OF_LANDING", allocationSize = 1, initialValue = 100000)
    private Long id;

    @NotBlank
    @Column(name = "C_DOCUMENT_NO", unique = true, nullable = false)
    private String documentNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTACT_SHIPPER_EXPORTER",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_CONTACT_AS_EXPORTER"),
            insertable = false,
            updatable = false
    )
    private Contact shipperExporter;

    @NotNull
    @Column(name = "F_CONTACT_SHIPPER_EXPORTER", nullable = false)
    private Long shipperExporterId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTACT_NOTIFY_PARTY",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_CONTACT_AS_NOTIFY_PARTY"),
            insertable = false,
            updatable = false
    )
    private Contact notifyParty;
    @NotNull
    @Column(name = "F_CONTACT_NOTIFY_PARTY", nullable = false)
    private Long notifyPartyId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTACT_CONSIGNEE_EXPORTER",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_CONTACT_AS_CONSIGNEE"),
            insertable = false,
            updatable = false
    )
    private Contact consignee;

    @NotNull
    @Column(name = "F_CONTACT_CONSIGNEE_EXPORTER", nullable = false)
    private Long consigneeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_PORT_AS_LOADING",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_PORT_AS_LOADING"),
            insertable = false,
            updatable = false
    )
    private Port portOfLoading;


    @NotNull
    @Column(name = "F_PORT_AS_LOADING", nullable = false)
    private Long portOfLoadingId;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_PORT_AS_DISCHARGE",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_PORT_AS_DISCHARGE"),
            insertable = false,
            updatable = false
    )
    private Port portOfDischarge;

    @NotNull
    @Column(name = "F_PORT_AS_DISCHARGE", nullable = false)
    private Long portOfDischargeId;

    @NotBlank
    @Column(name = "C_PLACE_OF_DELIVERY", nullable = false)
    private String placeOfDelivery;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_VESSEL",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_VESSEL"),
            insertable = false,
            updatable = false
    )
    private Vessel oceanVessel;

    @Column(name = "F_VESSEL", length = 4000)
    private Long oceanVesselId;


    @Column(name = "N_COPY_NUMBER_OF_BL")
    private Integer numberOfBlCopies;

    @Column(name = "D_DATE_OF_ISSUE")
    private Date dateOfIssue;


    @Column(name = "C_PLACE_OF_ISSUE")
    private String placeOfIssue;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;

    @Column(name = "C_DESCRIPTION_REMITTANCE", length = 4000)
    private String descriptionRemittance;

    @Column(name = "C_DESCRIPTION_CONTAINER", length = 4000)
    private String descriptionContainer;

    @OneToMany(mappedBy = "billOfLanding", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceToBillOfLanding> remittances;

    @OneToMany(mappedBy = "billOfLanding", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<ContainerToBillOfLanding> containers;

    @Column(name = "N_TOTAL_NET")
    private Integer totalNet;

    @Column(name = "N_TOTAL_GROSS")
    private Integer totalGross;

    @Column(name = "N_TOTAL_BUNDLES")
    private Integer totalBundles;


    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_shipment_id",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_shipment"),
            insertable = false,
            updatable = false
    )
    private Shipment shipment;


    //    @NotNull
    @Column(name = "F_shipment_id")
    private Long shipmentId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_shipment_type_id",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_shipment_type"),
            insertable = false,
            updatable = false
    )
    private ShipmentType shipmentType;


    //    @NotNull
    @Column(name = "F_shipment_type_id")
    private Long shipmentTypeId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_shipment_method_id",
            foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_shipment_method"),
            insertable = false,
            updatable = false
    )
    private ShipmentMethod shipmentMethod;


    //    @NotNull
    @Column(name = "F_shipment_method_id")
    private Long shipmentMethodId;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "F_BILL_OF_LANDING_TO_SWITCH", foreignKey = @ForeignKey(name = "FK_BILL_OF_LANDING_TO_SWITCH") ,updatable = false,insertable = false)
    private BillOfLadingSwitch billOfLadingSwitch;

    @Column(name = "F_BILL_OF_LANDING_TO_SWITCH")
    private Long billOfLadingSwitchId;
}
