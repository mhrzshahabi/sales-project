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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PARAMETER_SEQ")
    @SequenceGenerator(name = "PARAMETER_SEQ", sequenceName = "SEQ_PARAMETER_ID",allocationSize = 1)
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "PARAM_NAME", nullable = false)
    private String paramName;

    @Column(name = "PARAM_TYPE", nullable = false)
    private String paramType;

    @Column(name = "PARAM_Value", nullable = false)
    private String paramValue;
}
