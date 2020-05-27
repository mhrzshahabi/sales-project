package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Getter;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Column;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_Shipment_Method")
public class ShipmentMethod extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_Shipment_Method")
    @SequenceGenerator(name = "SEQ_Shipment_Method", sequenceName = "SEQ_Shipment_Method", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "Ship_Method", nullable = false, length = 200)
    private String shipmentMethod;


}
