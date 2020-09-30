package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.I18n;
import lombok.*;
import lombok.experimental.Accessors;

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
@Table(name = "TBL_COUNTRY")
public class Country extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_COUNTRY")
    @SequenceGenerator(name = "SEQ_COUNTRY", sequenceName = "SEQ_COUNTRY", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_NAME_FA", nullable = false)
    private String nameFA;

    @NotNull
    @Column(name = "C_NAME_EN", nullable = false)
    private String nameEN;

    @I18n
    @Transient
    private String name;
}
