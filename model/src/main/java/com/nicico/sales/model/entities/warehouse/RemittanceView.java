package com.nicico.sales.model.entities.warehouse;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("select * from VIEW_REMITTANCE")
public class RemittanceView {
    @Id
    @Column(name = "F_REMITTANCE_id")
    private Long id;
    @Column(name = "F_REMITTANCE_id", insertable = false, updatable = false)
    private Long remittanceId;
//    @OneToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "F_REMITTANCE_id", insertable = false, updatable = false)
//    private Remittance remittance;
    @Column(name = "N_AMOUNT")
    private Long amount;
    @Column(name = "F_DEPOT_ID")
    private Long fDepotId;
    @Column(name = "C_DESCRIPTION")
    private String cDescription;
    @Column(name = "F_DESTINATION_TOZINE_ID")
    private Long destinationTozineId;
    @Column(name = "F_INVENTORY_ID")
    private Long inventoryId;
    @Column(name = "RAIL_POLOMP_NO")
    private String railPolompNo;
    @Column(name = "SECURITY_POLOMP_NO")
    private String securityPolompNo;
    @Column(name = "F_SOURCE_TOZINE_ID")
    private Long sourceTozineId;
    @Column(name = "F_UNIT_ID")
    private Long unitId;
    @Column(name = "N_WEIGHT")
    private Long weight;
    @Column(name = "inventory_label")
    private String inventoryLabel;
    @Column(name = "remained_bandar")
    private Boolean remainedBandar;
    @Column(name = "now_target")
    private Long nowTarget;
    @Column(name = "first_target")
    private Long firstTarget;
    @Column(name = "now_rd")
    private Long nowRd;
    @Column(name = "now_r")
    private Long nowR;
    @Column(name = "first_rd")
    private Long firstRd;
    @Column(name = "first_r")
    private Long firstR;
    @Column(name = "tozin_table_id")
    private String tozinTableId;
    @Column(name = "CARD_ID")
    private String cardId;
    @Column(name = "GDSCODE")
    private Long gdscode;
    @Column(name = "CONTENER_NO3")
    private String contenerNo3;
    @Column(name = "CTRL_DESC_OUT")
    private String ctrlDescOut;
    @Column(name = "DAT")
    private String dat;
    @Column(name = "DRVNAME")
    private String drvname;
    @Column(name = "HAVCODE")
    private String havcode;
    @Column(name = "B_IS_IN_VIEW")
    private String isInView;
    @Column(name = "PLAK")
    private String plak;
    @Column(name = "C_CODE")
    private String remittanceCode;
    @Column(name = "remittance_description")
    private String remittanceDescription;
    @Column(name = "F_SHIPMENT_ID")
    private Long shipmentId;
    @Column(name = "F_PACKING_CONTAINER_ID")
    private Long packingContainerId;
    @Column(name = "C_AUTOMATION_LETTER_NO")
    private String automationLetterNo;
    @Column(name = "shipmails")
    private String automationLetterNoList;
    @Column(name = "D_AUTOMATION_LETTER_DATE")
    private String automationLetterDate;
    @Column(name = "SOURCEID")
    private Long sourceid;
    @Column(name = "TARGETID")
    private Long targetid;
    @Column(name = "TOZINE_ID")
    private String tozineId;
    @Column(name = "WAZN")
    private Long wazn;
    @Column(name = "remittance_wazn")
    private Long remittanceWeight;
    @Column(name = "B_IS_RAIL")
    private Boolean bIsRail;
    @Column(name = "has_tafkiki")
    private Boolean hasSeparated;


}
