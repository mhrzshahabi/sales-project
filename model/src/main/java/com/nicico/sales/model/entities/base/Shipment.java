package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
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
    @JoinColumn(name = "CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2contract"))
    private Contract contract;

    @Column(name = "CONTRACT_ID")
    private Long contractId;

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

    @Column(name = "CONTAINER_TYPE", length = 20)
    private String containerType;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "LOADING", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2portByLoading"))
    private Port portByLoading;

    @Column(name = "LOADING")
    private Long portByLoadingId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DISCHARGE", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2portBydisch"))
    private Port portByDischarge;

    @Column(name = "DISCHARGE")
    private Long portByDischargeId;

    @Column(name = "DISCHARGE_ADDRESS", length = 4000)
    private String dischargeAddress;

    @Column(name = "DESCRIPTION", length = 4000)
    private String description;

    @Column(name = "STATUS", length = 20)
    private String status;

    @Column(name = "MONTH", length = 20)
    private String month;

    @Column(name = "CREATE_DATE")
    private Date createDate;
//    private String createDate;

    @Column(name = "FILE_NAME")
    private String fileName;

    @Column(name = "NEW_FILE_NAME")
    private String newFileName;

    @Column(name = "SHIPMENT_TYPE")
    private String shipmentType;

    @Column(name = "SHIPMENT_METHOD")
    private String shipmentMethod;

    @Column(name = "LAYCAN")
    private String laycan;

    @Column(name = "SWITCH_BL_NUMBERS", length = 4000)
    private String switchBl;

    @Column(name = "SWB")
    private String swb;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SWITCH_PORT", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2portBysw"))
    private Port switchPort;

    @Column(name = "SWITCH_PORT")
    private Long switchPortId;

    @Column(name = "NO_BUNDLE")
    private Integer noBundle;

    @Column(name = "LOADING_LETTER")
    private String loadingLetter;

    @Column(name = "BL_NUMBERS", length = 4000)
    private String blNumbers;

    @Column(name = "NO_OF_BL")
    private long numberOfBLs;

    @Column(name = "BL_DATE", length = 20)
    private Date blDate;
//    private String blDate;

    @Column(name = "SW_BL_DATE")
    private Date swBlDate;
//    private String swBlDate;

    @Column(name = "CONSIGNEE")
    private String consignee;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "AGENT", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "shipmnt2contactAgent"))
    private Contact contactByAgent;

    @Column(name = "AGENT")
    private Long contactByAgentId;

    @Column(name = "FREIGHT")
    private Double freight;

    @Column(name = "TOTAL_FREIGHT")
    private Double totalFreight;

    @Column(name = "FREIGHT_CUR", length = 20)
    private String freightCurrency;

    @Column(name = "PRE_FREIGHT")
    private Double preFreight;

    @Column(name = "PRE_REIGHT_CUR", length = 20)
    private String preFreightCurrency;

    @Column(name = "POST_FREIGHT")
    private Double postFreight;

    @Column(name = "POST_REIGHT_CUR", length = 20)
    private String postFreightCurrency;

    @Column(name = "NO_BARREL")
    private Long noBarrel;

    @Column(name = "NO_PALETE")
    private Long noPalete;

    @Column(name = "DEMURRAGE")
    private Double demurrage;

    @Column(name = "DISPATCH")
    private Double dispatch;

    @Column(name = "DETENSION")
    private Double detention;

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
}
