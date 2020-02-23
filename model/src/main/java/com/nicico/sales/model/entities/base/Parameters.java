package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_PARAMETER")
public class Parameters extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PARAMETER")
    @SequenceGenerator(name = "SEQ_PARAMETER", sequenceName = "SEQ_PARAMETER", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "PARAM_NAME", nullable = false)
    private String paramName;

    @Column(name = "PARAM_Value", nullable = false)
    private String paramValue;

    @Column(name = "CONTRACT_ID", nullable = false)
    private Integer contractId;

    @Column(name = "CATEGORY_VALUE", nullable = false)
    private Integer categoryValue;

}
