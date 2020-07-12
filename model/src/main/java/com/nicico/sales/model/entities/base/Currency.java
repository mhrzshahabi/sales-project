package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.SymbolCurrency;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

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

    @NotNull
    @Column(name = "C_NAME_FA" , nullable = false)
    private String nameFa;

    @Column(name = "C_NAME_EN" , nullable = false)
    private String nameEn;

    @Column(name = "N_SYMBOL_CURRENCY" )
    private SymbolCurrency symbolCurrency;

}
