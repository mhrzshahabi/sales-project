package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.TozinSalesId;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("select * from view_tozin_s")
@IdClass(TozinSalesId.class)
public class TozinSales {

    @Id
    @Column(name = "PID")
    private Long pId;
    @Id
    @Column(name = "CARD_ID")
    private String cardId;
    @Id
    @Column(name = "CARNO1")
    private String carNo1;
    @Column(name = "CARNO3")
    private String carNo3;
    @Column(name = "PLAK")
    private String plak;
    @Id
    @Column(name = "CARNAME")
    private String carName;
    @Column(name = "CUSTOMERID")
    private String customerId;
    @Id
    @Column(name = "CUSTOMER")
    private String customer;
    @Column(name = "SELLERID")
    private String sellerId;
    @Id
    @Column(name = "SELLER")
    private String seller;
    @Column(name = "TOZINE_ID")
    private String tozinId;
    @Id
    @Column(name = "tozin_plant_id")
    private String tozinPlantId;
    @Column(name = "WAZN1")
    private Long vazn1;
    @Column(name = "WAZN2")
    private Long vazn2;
    @Column(name = "CONDITION")
    private String condition;
    @Column(name = "WAZN")
    private Long vazn;
    @Column(name = "TEDAD")
    private Long tedad;
    @Column(name = "UNIT_KALA")
    private Long unitKala;
    @Column(name = "PACKNAME")
    private String packName;
    @Column(name = "HAVCODE")
    private String haveCode;
    @Column(name = "DAT")
    private String date;
    @Column(name = "TZN_DATE")
    private String tozinDate;
    @Column(name = "TZN_TIME")
    private String tozinTime;
    @Id
    @Column(name = "GDSCODE")
    private Long codeKala;
    @Id
    @Column(name = "GDSNAME")
    private String nameKala;
    @Column(name = "SOURCEID")
    private Long sourceId;
    @Id
    @Column(name = "SOURCEE")
    private String source;
    @Column(name = "TARGETID")
    private Long targetId;
    @Id
    @Column(name = "TARGET")
    private String target;
    @Column(name = "HAV_NAME")
    private String havalehName;
    @Column(name = "HAV_DATE")
    private String havalehDate;
    @Id
    @Column(name = "HAV_ISFINAL")
    private String isFinal;
    @Column(name = "source_plant_id")
    private String sourcePlantId;
    @Column(name = "target_plant_id")
    private String targetPlantId;

}
