package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;

import javax.persistence.*;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_Shipment_Type")
public class ShipmentType extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_Shipment_Type")
    @SequenceGenerator(name = "SEQ_Shipment_Type", sequenceName = "SEQ_Shipment_Type", allocationSize = 1)
    @Column(name = "ID")
    private Long id;


    @Column(name = "Ship_Type", nullable = false)
    private String shipmentType;


}
