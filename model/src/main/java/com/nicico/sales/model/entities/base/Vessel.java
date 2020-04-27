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
@Table(name = "TBL_VESSEL")
public class Vessel extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_VESSEL")
    @SequenceGenerator(name = "SEQ_VESSEL", sequenceName = "SEQ_VESSEL", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "TYPE")
    private String type;

    @Column(name = "IMO")
    private Long imo;

    @Column(name = "YEAR_OF_BUILd")
    private Long yearOfBuild;

    @Column(name = "LENGTH")
    private Double length;

    @Column(name = "BEAM")
    private Double beam;

}
