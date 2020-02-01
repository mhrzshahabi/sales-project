package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import oracle.jdbc.proxy.annotation.Pre;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("select * from N_MASTER.V_CATODLISTFOREXPORT")
@IdClass(CathodeListId.class)
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

}