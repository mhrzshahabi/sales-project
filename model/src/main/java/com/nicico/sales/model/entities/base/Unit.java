package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.model.enumeration.I18n;
import com.nicico.sales.model.enumeration.SymbolUnit;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@I18n
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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_UNIT")
    @GenericGenerator(name = "SEQ_UNIT", strategy = "com.nicico.sales.model.entities.common.IdKeepingSequenceGenerator", parameters = {})
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_NAME_FA", nullable = false)
    private String nameFA;

    @NotNull
    @Column(name = "C_NAME_EN", nullable = false)
    private String nameEN;

    @Column(name = "N_CATEGORY_UNIT")
    private CategoryUnit categoryUnit;

    @Column(name = "N_SYMBOL_UNIT")
    private SymbolUnit symbolUnit;

    @I18n
    @Transient
    private String name;
}
