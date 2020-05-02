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
@Table(name = "TBL_CNTR_INCOTERM_RULES")
public class IncotermRules extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_RULES")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_RULES", sequenceName = "SEQ_CNTR_INCOTERM_RULES", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermRules2incotermByIncotermId"))
    private Incoterm incoterm;

    @NotNull
    @Column(name = "F_INCOTERM_ID", nullable = false)
    private Long incotermId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_RULE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermRules2incotermRuleByIncotermRuleId"))
    private IncotermRule incotermRule;

    @NotNull
    @Column(name = "F_INCOTERM_RULE_ID", nullable = false)
    private Long incotermRuleId;
}
