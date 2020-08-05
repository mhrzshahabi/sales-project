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
@Table(name = "TBL_PERCENT_PER_YEAR")
public class PercentPerYear extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PERCENT_PER_YEAR")
    @SequenceGenerator(name = "SEQ_PERCENT_PER_YEAR", sequenceName = "SEQ_PERCENT_PER_YEAR", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "YEAR")
    private Long year;

    @Column(name = "N_C_VAT")
    private Double cVat;

    @Column(name = "N_T_VAT")
    private Double tVat;

}
