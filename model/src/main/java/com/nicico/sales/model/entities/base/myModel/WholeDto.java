package com.nicico.sales.model.entities.base.myModel;


import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WHOLE_DAily")
public class WholeDto implements Cloneable {

    /*{"warehouseNo", "toDay", "descp", "plant", "packingType", */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(name = "warehouse_No")
    private String warehouseNo;
    @Column(name = "to_Day")
    private String toDay;
    private String descp;
    private String plant;
    @Column(name = "packing_Type")
    private String packingType;

    @Column(name = "amount_Day")
    private Integer amountDay;
    @Column(name = "amount_Import_Day")
    private Integer amountImportDay;
    @Column(name = "amount_First_Day")
    private Integer amountFirstDay;
    @Column(name = "amount_Export_Day")
    private Integer amountExportDay;
    @Column(name = "amount_Revise_Day")
    private Integer amountReviseDay;
    @Column(name = "amount_First_Mon")
    private Integer amountFirstMon;
    @Column(name = "amount_Import_Mon")
    private Integer amountImportMon;
    @Column(name = "amount_Export_Mon")
    private Integer amountExportMon;
    @Column(name = "amount_Revise_Mon")
    private Integer amountReviseMon;
    @Column(name = "amount_First_Sal")
    private Integer amountFirstSal;
    @Column(name = "amount_Import_Sal")
    private Integer amountImportSal;
    @Column(name = "amount_Export_Sal")
    private Integer amountExportSal;
    @Column(name = "amount_Revise_Sal")
    private Integer amountReviseSal;
    @Column(name = "revise_Sal")
    private Integer reviseSal;
    private Integer aa;




}

