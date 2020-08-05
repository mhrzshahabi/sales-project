package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_INCOTERM_FORM")
public class IncotermForm extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_FORM")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_FORM", sequenceName = "SEQ_CNTR_INCOTERM_FORM", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_CODE", nullable = false, unique = true)
    private String code;

    @NotEmpty
    @Column(name = "C_TITLE", nullable = false)
    private String title;
}
