package com.nicico.sales.model.entities.base;

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
@Subselect("select * from n_master.v_tozine_content_b")
@IdClass(TozinSales.TozinSalesId.class)
public class TozinSales {

    @Id
    @Column(name = "CUSTOMER")
    private String customer;
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
    @Column(name = "CARD_ID")
    private String cardId;
    @Id
    @Column(name = "TARGET")
    private String target;
    @Id
    @Column(name = "CARNAME")
    private String carName;
    @Id
    @Column(name = "CARNO1")
    private String carNo1;
    @Id
    @Column(name = "SELLER")
    private String seller;
    @Id
    @Column(name = "ISOKY")
    private String isFinal;
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
    @Column(name = "SELLERID")
    private String sellerId;
    @Column(name = "CUSTOMERID")
    private String customerId;
    @Column(name = "PACKNAME")
    private String packName;
    @Column(name = "UNIT_KALA")
    private String unitKala;
    @Column(name = "TEDAD")
    private Long tedad;
    @Column(name = "WAZN")
    private Long vazn;
    @Column(name = "CONDITION")
    private String condition;
    @Column(name = "WAZN2")
    private Long vazn2;
    @Column(name = "WAZN1")
    private Long vazn1;
    @Column(name = "CARPELAK")
    private String carPelak;
    @Column(name = "CARNO3")
    private String carNo3;
    @Column(name = "HAVCODE")
    private String haveCode;

    @EqualsAndHashCode(callSuper = false)
    public static class TozinSalesId implements Serializable {
        private String customer;
        private String source;
        private String tozinId;
        private String nameKala;
        private Long codeKala;
        private String cardId;
        private String target;
        private String carName;
        private String carNo1;
        private String seller;
        private String isFinal;
    }

}
