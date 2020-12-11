package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import com.nicico.sales.model.entities.contract.ContractShipment;
import com.nicico.sales.model.entities.warehouse.Remittance;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Formula;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Set;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_SHIPMENT")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class Shipment extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT")
    @SequenceGenerator(name = "SEQ_SHIPMENT", sequenceName = "SEQ_SHIPMENT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_SHIPMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2contractShipmentByContractShipmentId"))
    private ContractShipment contractShipment;

    @NotNull
    @Column(name = "F_CONTRACT_SHIPMENT_ID", nullable = false)
    private Long contractShipmentId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2shipmentTypeByShipmentTypeId"))
    private ShipmentType shipmentType;

    @NotNull
    @Column(name = "F_SHIPMENT_TYPE_ID", nullable = false)
    private Long shipmentTypeId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_METHOD_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2shipmentMethodByShipmentMethodId"))
    private ShipmentMethod shipmentMethod;

    @NotNull
    @Column(name = "F_SHIPMENT_METHOD_ID", nullable = false)
    private Long shipmentMethodId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2ContactByContactId"))
    private Contact contact;

    @NotNull
    @Column(name = "F_CONTACT_ID", nullable = false)
    private Long contactId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_AGENT_CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2ContactByContactAgentId"))
    private Contact contactAgent;

    @NotNull
    @Column(name = "F_AGENT_CONTACT_ID", nullable = false)
    private Long contactAgentId;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2materialByMaterialId"))
    private Material material;

    @Column(name = "F_MATERIAL_ID")
    private Long materialId;

    @Setter(AccessLevel.NONE)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_VESSEL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2vesselByVesselId"))
    private Vessel vessel;

    @Column(name = "F_VESSEL_ID")
    private Long vesselId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2unitByUnitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DISCHARGE_PORT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipment2portByDischargePortId"))
    private Port dischargePort;

    @NotNull
    @Column(name = "DISCHARGE_PORT_ID", nullable = false)
    private Long dischargePortId;

    @NotNull
    @Column(name = "N_AMOUNT", nullable = false, scale = 3, precision = 12)
    private BigDecimal amount;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;

    @Column(name = "C_CONTAINER_TYPE")
    private String containerType;

//    @Column(name = "STATUS", length = 20)
//    private String status;

    @Column(name = "C_AUTOMATION_LETTER_NO")
    private String automationLetterNo;

    @Column(name = "D_AUTOMATION_LETTER_DATE")
    private Date automationLetterDate;

    @NotNull
    @Column(name = "D_SEND_DATE", nullable = false)
    private Date sendDate;

//    @Column(name = "FILE_NAME")
//    private String fileName;
//
//    @Column(name = "NEW_FILE_NAME")
//    private String newFileName;

//    @Column(name = "SHIPMENT_TYPE")
//    private String shipmentType;
//
//    @Column(name = "SHIPMENT_METHOD")
//    private String shipmentMethod;

    @NotNull
    @Column(name = "N_NO_BLS", nullable = false)
    private Long noBLs;

    @NotAudited
    @Formula("( select N_NO_BLS - (select count(TBL_CNTR_BILL_OF_LANDING.ID) " +
            "from TBL_CNTR_BILL_OF_LANDING where TBL_CNTR_BILL_OF_LANDING.F_SHIPMENT_ID = id) from dual)")
    private Long remainedBLs;

    @OneToMany(mappedBy = "shipmentId", fetch = FetchType.LAZY)
    private Set<BillOfLanding> bls;
    @Column(name = "N_NO_CONTAINER")
    private Long noContainer;

    @Column(name = "N_NO_PACKAGES")
    private Long noPackages;

//    @Setter(AccessLevel.NONE)
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "AGENT", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2contactAgent"))
//    private Contact contactByAgent;
//
//    @Column(name = "AGENT")
//    private Long contactByAgentId;

    @Column(name = "N_NO_PALLET")
    private Long noPallet;

    @Column(name = "BOOKING_NO_CAT")
    private String bookingCat;

//    @OneToMany(mappedBy = "shipment", fetch = FetchType.LAZY)
//    private Set<Invoice> invoices;

    @Column(name = "N_WEIGHT_G_W", scale = 5, precision = 10)
    private BigDecimal weightGW;

    @Column(name = "N_WEIGHT_N_D", scale = 5, precision = 10)
    private BigDecimal weightND;

    @Column(name = "VGM")
    private Double vgm;

     @Column(name = "D_ARRIVAL_DATE_FROM")
     private Date arrivalDateFrom;

     @Column(name = "D_ARRIVAL_DATE_TO")
     private Date arrivalDateTo;


    @OneToMany(mappedBy = "shipmentId", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<Remittance> remittances;


    @Column(name = "D_LAST_DELIVERY_LETTER_DATE")
    private Date lastDeliveryLetterDate;

}
