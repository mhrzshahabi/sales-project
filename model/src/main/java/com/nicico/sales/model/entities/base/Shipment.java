package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_SHIPMENT")
public class Shipment extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT")
    @SequenceGenerator(name = "SEQ_SHIPMENT", sequenceName = "SEQ_SHIPMENT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_SHIPMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2contractShipment"))
    private ContractShipment contractShipment;

    @Column(name = "CONTRACT_SHIPMENT_ID")
    private Long contractShipmentId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2Contactbybuyer"))
    private Contact contact;

    @Column(name = "CONTACT_ID")
    private Long contactId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2material"))
    private Material material;

    @Column(name = "MATERIAL_ID")
    private Long materialId;

    @Column(name = "AMOUNT", nullable = false)
    private Double amount;

    @Column(name = "CONTAINER")
    private Long noContainer;

    @Column(name = "DESCRIPTION", length = 4000)
    private String description;

    @Column(name = "STATUS", length = 20)
    private String status;

    @Column(name = "SHIPMENT_DATE")
    private Date shipmentDate;

    @Column(name = "SEND_DATE")
    private Date sendDate;

    @Column(name = "FILE_NAME")
    private String fileName;

    @Column(name = "NEW_FILE_NAME")
    private String newFileName;

    @Column(name = "SHIPMENT_TYPE")
    private String shipmentType;

    @Column(name = "SHIPMENT_METHOD")
    private String shipmentMethod;
    @Column(name = "LOADING_LETTER")
    private String loadingLetter;

    @Column(name = "NO_OF_BL")
    private long numberOfBLs;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "AGENT", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2contactAgent"))
    private Contact contactByAgent;

    @Column(name = "AGENT")
    private Long contactByAgentId;

    @Column(name = "NO_BARREL")
    private Long noBarrel;

    @Column(name = "NO_PALETE")
    private Long noPalete;

    @Column(name = "BOOKING_NO_cat")
    private String bookingCat;

    @Setter(AccessLevel.NONE)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VESSEL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "Shipment2vessel"))
    private Vessel vessel;

    @Column(name = "VESSEL_ID")
    private Long vesselId;

    @NotAudited
    @OneToMany(mappedBy = "shipment", fetch = FetchType.LAZY)
    private Set<Invoice> invoices;

    @Column(name = "GROSS")
    private Double gross;

    @Column(name = "NET")
    private Double net;

    @Column(name = "MOISTURE")
    private Double moisture;

    @Column(name = "VGM")
    private Double vgm;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2unitByUnitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

}
