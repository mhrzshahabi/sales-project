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
@Subselect("select * from N_MDMS.V_CATODLISTFOREXPORT")
@IdClass(CathodeList.CathodeListId.class)
public class CathodeList {

    @Id
    @Column(name = "STOREID")
    private String storeId;

    @Id
    @Column(name = "TOZINEID")
    private String tozinId;

    @Id
    @Column(name = "PRODUCTID")
    private String productId;

    @Id
    @Column(name = "PRODUCTLABEL")
    private String productLabel;

    @Id
    @Column(name = "WAZN")
    private Long wazn;

    @Id
    @Column(name = "SHEETNUMBER")
    private Long sheetNumber;

    @Id
    @Column(name = "PACKINGTYPEID")
    private Long packingTypeId;

    @Id
    @Column(name = "GDSCODE")
    private Long gdsCode;

    @EqualsAndHashCode(callSuper = false)
    public static class CathodeListId implements Serializable {
        private String storeId;
        private String tozinId;
        private String productId;
        private String productLabel;
        private Long wazn;
        private Long sheetNumber;
        private Long packingTypeId;
        private Long gdsCode;
    }

}