package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_Analyse_Product_MO")
public class AnalysisMo extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_Analyse_Product_MO")
    @SequenceGenerator(name = "SEQ_Analyse_Product_MO", sequenceName = "SEQ_Analyse_Product_MO", allocationSize = 1)
    @Column(name = "ID")
    private Long id;


    @Column(name = "LOT_NAME", nullable = false, length = 40)
    private String lotName;

    @Column(name = "MO")
    private Double mo;

    @Column(name = "CU")
    private Double cu;

    @Column(name = "SI")
    private Double si;

    @Column(name = "PB")
    private Double pb;

    @Column(name = "S")
    private Double s;

    @Column(name = "C")
    private Double c;

    @Column(name = "P")
    private Double p;
}

