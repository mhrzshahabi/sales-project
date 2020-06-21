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
@Table(name = "TBL_RATE")
public class Rate extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_RATE")
    @SequenceGenerator(name = "SEQ_RATE", sequenceName = "SEQ_RATE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "NAME_FA", nullable = false, length = 200)
    private String nameFA;

    @Column(name = "NAME_EN", nullable = false, length = 200)
    private String nameEN;

    @Column(name = "SYMBOL")
    private String symbol;

    @Column(name = "DECIMAL_DIGITS")
    private Long decimalDigit;
}
