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
@Table(name = "TBL_CURRENCY")
public class Currency extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CURRENCY")
    @SequenceGenerator(name = "SEQ_CURRENCY", sequenceName = "SEQ_CURRENCY", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_NAME_FA")
    private String nameFa;

    @Column(name = "c_NAME_EN")
    private String nameEn;

    @Column(name = "c_SYMBOL", length = 20)
    private String symbol;

}
