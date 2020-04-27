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
@Table(name = "TBL_CNTR_INCOTERM_STEPS")
public class IncotermSteps extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_STEPS")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_STEPS", sequenceName = "SEQ_CNTR_INCOTERM_STEPS", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermSteps2incotermByIncotermId"))
    private Incoterm incoterm;

    @NotNull
    @Column(name = "F_INCOTERM_ID", nullable = false)
    private Long incotermId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_STEP_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermSteps2incotermStepByIncotermStepId"))
    private IncotermStep incotermStep;

    @NotNull
    @Column(name = "F_INCOTERM_STEP_ID", nullable = false)
    private Long incotermStepId;
}
