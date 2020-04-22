package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_CNTR_INCOTERM_RULE")
public class IncotermRule extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_RULE")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_RULE", sequenceName = "SEQ_CNTR_INCOTERM_RULE", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_TITLE", nullable = false, length = 200)
    private String title;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;
}