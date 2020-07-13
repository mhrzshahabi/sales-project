package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.model.enumeration.SymbolUnit;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.*;
import javax.validation.constraints.NotNull;

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
    @SequenceGenerator(name = "SEQ_UNIT", sequenceName = "SEQ_UNIT", allocationSize = 1, initialValue = 1000000)
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_NAME_FA", nullable = false)
    private String nameFA;

    @NotNull
    @Column(name = "C_NAME_EN", nullable = false)
    private String nameEN;

    @NotNull
    @Column(name = "N_CATEGORY_UNIT" , nullable = false)
    private CategoryUnit categoryUnit ;

    @NotNull
    @Column(name = "N_SYMBOL_UNIT" , nullable = false)
    private SymbolUnit symbolUnit;
}
