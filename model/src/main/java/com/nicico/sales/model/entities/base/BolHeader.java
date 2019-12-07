package com.nicico.sales.model.entities.base;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

/**
 * mehdi 9802
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_BOL_HEADER")
public class BolHeader {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO , generator = "base_seq")
    @SequenceGenerator(name = "base_seq", sequenceName = "SALES.SEQ_BOL")
    @Column(name = "ID", precision = 10)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "SHIPMENT_ID")
    private Shipment tblShipment;

    @ManyToOne
    @JoinColumn(name = "SHIPMENT_CONTRACT_ID")
    private ShipmentContract shipmentContract;

    @Column(name = "GROSS_WEIGHT")
    private Double grossWeight;

    @Column(name = "NET_WEIGHT")
    private Double netWeight;

    @Column(name = "CONTAINER")
    private Long noContainer;

    @Column(name = "BUNDLE")
    private Long noBundle;

    @Column(name = "BL_NO", nullable = false,length = 100)
    private String blNo;

    @Column(name = "SWBL_NO",length = 100)
    private String swBlNo;

    @ManyToOne
    @JoinColumn(name = "DISCHARGE")
    private Port tblPortByDischarge;

    @ManyToOne
    @JoinColumn(name = "SWITCH_PORT")
    private Port tblSwitchPort;

    @Column(name = "PALATE")
    private Long noPalete;

    @Column(name = "BOL_DATE", length = 100)
    private String bolDate;

    @Column(name = "CREATE_DATE", length = 100)
    private String createDate;
    //------------------------------------------------------------ to Add auto create and update date ------------------------------------------------
    @Transient
    private String createDateFa;

    @Transient
    private String editDateFA;
}
