package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_SHIPMENT_CONTRACT", uniqueConstraints = @UniqueConstraint(name = "SHIPMENTCONTRACT_NO_UNIQUE", columnNames = {"NO"}))
public class ShipmentContract extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_CONTRACT")
    @SequenceGenerator(name = "SEQ_SHIPMENT_CONTRACT", sequenceName = "SEQ_SHIPMENT_CONTRACT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "OWNERS", nullable = false, insertable = false, updatable = false)
    private Contact tblContactByOwners;

    @Column(name = "OWNERS")
    private Long contactByOwnersId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CHARTERER", nullable = false, insertable = false, updatable = false)
    private Contact tblContactByCharterer;

    @Column(name = "CHARTERER")
    private Long contactByChartererId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CHAIN_OF_OWNERS", nullable = false, insertable = false, updatable = false)
    private Contact tblContactByChainOfOwners;

    @Column(name = "CHAIN_OF_OWNERS")
    private Long contactByChainOfOwnersId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FLAG", nullable = false, insertable = false, updatable = false)
    private Country tblCountryFlag;  //ok

    @Column(name = "FLAG")
    private Long countryFlagId;

    @Column(name = "SHIPMENT_CONTRACT_DATE", length = 20)
    private String shipmentContractDate;

    @Column(name = "NO", length = 20)
    private String no;

    @Column(name = "CAPACITY")
    private Double capacity;

    @Column(name = "LAYCAN_START", length = 20)
    private String laycanStart;

    @Column(name = "LAYCAN_END", length = 20)
    private String laycanEnd;

    @Column(name = "LOADING_RATE", length = 100)
    private String loadingRate;

    @Column(name = "DISCHARGE_RATE", length = 100)
    private String dischargeRate;

    @Column(name = "DEMURRAGE")
    private Double demurrage;

    @Column(name = "DISPATCH")
    private Double dispatch;

    @Column(name = "FREIGHT")
    private Double freight;

    @Column(name = "BALE")
    private String bale;

    @Column(name = "GRAIN")
    private String grain;

    @Column(name = "GROSS_WEIGHT")
    private String grossWeight;

    @Column(name = "VESSEL_NAME", length = 1000)
    private String vesselName;

    @Column(name = "YEAR_OF_BUILT", length = 20)
    private String yearOfBuilt;

    @Column(name = "IMO_NO", length = 20)
    private String imoNo;

    @Column(name = "OFFICIAL_NO", length = 100)
    private Integer officialNo;

    @Column(name = "LOA", length = 100)
    private String loa;

    @Column(name = "BEAM", length = 100)
    private String beam;

    @Column(name = "CRANES", length = 100)
    private String cranes;

    @Column(name = "HOLDS", length = 100)
    private String holds;

    @Column(name = "HATCH", length = 100)
    private String hatch;

    @Column(name = "CLASS_TYPE", length = 100)
    private String classType;

    @Column(name = "WEIGHING_METHODES", length = 100)
    private String weighingMethodes;

    @Column(name = "SHIP_FLAG", length = 100)
    private String shipFlag;

    @Column(name = "CREATE_DATE", length = 100)
    private String createDate;

}
