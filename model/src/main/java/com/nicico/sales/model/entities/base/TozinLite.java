package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("select * from n_master.V_TOZINE_CONTENT_M2")
public class TozinLite {
    @Column(name = "CARNO1")
    private String carNo1;
    @Column(name = "CARNO3")
    private String carNo3;
    @Column(name = "PLAK")
    private String plak;
    @Column(name = "CONTENER_NO1")
    private String containerNo1;
    @Column(name = "CONTENER_NO3")
    private String containerNo3;
    @Id
    @Column(name = "TOZINE_ID")
    private String tozinId;
    @Column(name = "WAZN")
    private Long vazn;
    @Column(name = "TEDAD")
    private Long tedad;
    @Column(name = "UNIT_KALA")
    private Long unitKala;
    @Column(name = "HAVCODE")
    private Long havalehCode;
    @Column(name = "DAT")
    private Long date;
    @Column(name = "GDSCODE")
    private Long codeKala;
    @Column(name = "SOURCEID")
    private Long sourceId;
    @Column(name = "TARGETID")
    private Long targetId;
    @Column(name = "DRVNAME")
    private String driverName;

}