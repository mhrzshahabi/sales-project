package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.annotation.I18n;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@I18n
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_Shipment_Method")
public class ShipmentMethod extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_Shipment_Method")
    @SequenceGenerator(name = "SEQ_Shipment_Method", sequenceName = "SEQ_Shipment_Method", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @I18n
    @Transient
    private String shipmentMethod;

    @Column(name = "C_SHIP_METHOD_FA")
    private String shipmentMethodFA;

    @Column(name = "C_SHIP_METHOD_EN")
    private String shipmentMethodEN;

}
