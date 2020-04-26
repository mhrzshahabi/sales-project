package com.nicico.sales.model.entities.warehouse;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import java.io.Serializable;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("select * from n_master.V_TOZINE_CONTENT_M")
@IdClass(Tozin.TozinId.class)
public class Tozin {

    @Id
    @Column(name = "SOURCEE")
    private String source;
    @Id
    @Column(name = "TOZINE_ID")
    private String tozinId;
    @Id
    @Column(name = "GDSNAME")
    private String nameKala;
    @Id
    @Column(name = "GDSCODE")
    private Long codeKala;
    @Id
    @Column(name = "TARGET")
    private String target;
    @Id
    @Column(name = "CARD_ID")
    private String cardId;
    @Column(name = "PLAK")
    private String plak;
    @Column(name = "CARNAME")
    private String carName;
    @Column(name = "CONTENER_ID")
    private String containerId;
    @Column(name = "CONTENER_NO1")
    private String containerNo1;
    @Column(name = "CONTENER_NO3")
    private String containerNo3;
    @Column(name = "CONTENER_NAME")
    private String containerName;
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
    @Column(name = "SOURCEID")
    private Long sourceId;
    @Column(name = "TARGETID")
    private Long targetId;
    @Column(name = "HAV_NAME")
    private String havalehName;
    @Column(name = "HAV_FROM")
    private String havalehFrom;
    @Column(name = "HAV_TO")
    private String havalehTo;
    @Column(name = "HAV_DATE")
    private String havalehDate;
    @Column(name = "CARNO1")
    private String carNo1;
    @Column(name = "CARNO3")
    private String carNo3;
    @Column(name = "HAV_ISFINAL")
    private String isFinal;
    @Column(name = "CTRL_DESC_OUT")
    private String ctrlDescOut;
    @Column(name = "TZN_SHARH2")
    private String tznSharh2;
    @Column(name = "STR_SHARH2")
    private String strSharh2;
    @Column(name = "TZN_SHARH1")
    private String tznSharh1;

    @EqualsAndHashCode(callSuper = false)
    public static class TozinId implements Serializable {
        private String source;
        private String tozinId;
        private String nameKala;
        private Long codeKala;
        private String target;
        private String cardId;
    }
}
