package com.nicico.sales.model.entities.base;


import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.SequenceGenerator;
import javax.persistence.GenerationType;
import javax.persistence.Column;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_Shipment_Type")
public class ShipmentType {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_Shipment_Type")
    @SequenceGenerator(name = "SEQ_Shipment_Type", sequenceName = "SEQ_Shipment_Type", allocationSize = 1)
    @Column(name = "ID")
    private Long id;


    @Column(name = "Ship_Type", nullable = false, length = 200)
    private String shipmentType;


}
