package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.I18n;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@I18n
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_SALES_TYPE")
public class SalesType extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SALES_TYPE")
    @SequenceGenerator(name = "SEQ_SALES_TYPE", sequenceName = "SEQ_SALES_TYPE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @I18n
    @Transient
    private String salesType;

    @Column(name = "C_SALES_TYPE_FA")
    private String salesTypeFA;

    @Column(name = "C_SALES_TYPE_EN")
    private String salesTypeEN;

}
