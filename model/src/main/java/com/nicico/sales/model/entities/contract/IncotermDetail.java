package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_INCOTERM_DETAIL")
public class IncotermDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_DETAIL")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_DETAIL", sequenceName = "SEQ_CNTR_INCOTERM_DETAIL", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_TERM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermDetail2termByTermId"))
    private Term term;

    @Column(name = "F_TERM_ID")
    private Long termId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_ASPECT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermDetail2incotermAspectByIncotermAspectId"))
    private IncotermAspect incotermAspect;

    @NotNull
    @Column(name = "F_INCOTERM_ASPECT_ID", nullable = false)
    private Long incotermAspectId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_STEPS_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermDetail2incotermStepsByIncotermStepsId"))
    private IncotermSteps incotermSteps;

    @NotNull
    @Column(name = "F_INCOTERM_STEPS_ID", nullable = false)
    private Long incotermStepsId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_RULES_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermDetail2incotermRulesByIncotermRulesId"))
    private IncotermRules incotermRules;

    @NotNull
    @Column(name = "F_INCOTERM_RULES_ID", nullable = false)
    private Long incotermRulesId;

    @OneToMany(mappedBy = "incotermDetail", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<IncotermParties> incotermParties;
}
