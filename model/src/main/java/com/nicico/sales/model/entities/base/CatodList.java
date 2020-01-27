package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Subselect("select * from N_MASTER.V_CATODLISTFOREXPORT")
public class CatodList {

    @Id
    @Column(name = "ID")
    private Long id;

    @Column(name = "STOREID")
    private String storeId;

    @Column(name = "TOZINEID")
    private String tozinId;

    @Column(name = "PRODUCTID")
    private String productId;

    @Column(name = "PRODUCTLABEL")
    private String productLabel;

    @Column(name = "WAZN")
    private Long wazn;

    @Column(name = "SHEETNUMBER")
    private Long sheetNumber;

    @Column(name = "PACKINGTYPEID")
    private Long packingTypeId;

    @Column(name = "GDSCODE")
    private Long gdsCode;

}