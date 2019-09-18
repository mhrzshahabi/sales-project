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
    private Double amountDay;
    @Column(name = "amount_Import_Day")
    private Double amountImportDay;
    @Column(name = "amount_First_Day")
    private Double amountFirstDay;
    @Column(name = "amount_Export_Day")
    private Double amountExportDay;
    @Column(name = "amount_Revise_Day")
    private Double amountReviseDay;
    @Column(name = "amount_First_Mon")
    private Double amountFirstMon;
    @Column(name = "amount_Import_Mon")
    private Double amountImportMon;
    @Column(name = "amount_Export_Mon")
    private Double amountExportMon;
    @Column(name = "amount_Revise_Mon")
    private Double amountReviseMon;
    @Column(name = "amount_First_Sal")
    private Double amountFirstSal;
    @Column(name = "amount_Import_Sal")
    private Double amountImportSal;
    @Column(name = "amount_Export_Sal")
    private Double amountExportSal;
    @Column(name = "amount_Revise_Sal")
    private Double amountReviseSal;
    @Column(name = "revise_Sal")
    private Double reviseSal;
    private Double aa;




}

