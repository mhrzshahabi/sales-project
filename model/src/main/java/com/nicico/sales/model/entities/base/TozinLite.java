package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;
import org.hibernate.envers.NotAudited;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("select * from V_TOZINE_CONTENT_M3")
public class TozinLite {
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
    @Column(name = "HAVCODE")
    private String havalehCode;
    //    @Column(name = "DAT")
    @Formula(value = "REPLACE(nvl(sal_date2,dat),'/','') ")
    private Long date;
    //    @Column(name = "DAT")
    @Formula(value = "REPLACE(nvl(sal_date2,dat),'/','') ")
    private String dateStr;
    @Column(name = "GDSCODE")
    private Long codeKala;
    @Column(name = "SOURCEID")
    private Long sourceId;
    @Column(name = "TARGETID")
    private Long targetId;
    @Column(name = "DRVNAME")
    private String driverName;

    @NotAudited
    @Formula(value = "(select TBL_WARH_TOZIN.id from TBL_WARH_TOZIN " +
            "where TBL_WARH_TOZIN.TOZINE_ID = TOZINE_ID  and ROWNUM = 1 )")
    private Long tozinTable;

    @NotAudited
    @Formula(value = "(case " +
            "when contener_no3 like '*'   " +
            "then 0  " +
            "when contener_no3 is not null " +
            "then 1 " +
            "when contener_no3 is null " +
            "     then 0 " +
            "end)")
    private Boolean isRail;

}
