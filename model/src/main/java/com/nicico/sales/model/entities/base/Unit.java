package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_UNIT")
public class Unit extends BaseEntity {

    @Id
    @GenericGenerator(name = "SEQ_UNIT", strategy = "com.nicico.sales.model.entities.common.IdKeepingSequenceGenerator")
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_UNIT")
//    @SequenceGenerator(name = "SEQ_UNIT", sequenceName = "SEQ_UNIT", allocationSize = 1, initialValue = 1000000)
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_NAME_FA", nullable = false, length = 200)
    private String nameFA;

    @Column(name = "c_NAME_EN", nullable = false, length = 200)
    private String nameEN;

    @Column(name = "c_SYMBOL")
    private String symbol;

    @Column(name = "CATEGORY_VALUE", nullable = false)
    private Integer categoryValue;

    @Column(name = "n_DECIMAL_DIGITS")
    private Long decimalDigit;

}
