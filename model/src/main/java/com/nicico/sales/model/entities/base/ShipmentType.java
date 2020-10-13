package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.I18n;
import lombok.*;

import javax.persistence.*;

@I18n
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


    @I18n
    @Transient
    private String shipmentType;

    @Column(name = "C_SHIP_TYPE_EN")
    private String shipmentTypeEN;

    @Column(name = "C_SHIP_TYPE_FA")
    private String shipmentTypeFA;

}
