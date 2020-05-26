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
@Table(name = "TBL_CNTR_INCOTERM_FORMS")
public class IncotermForms extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_FORMS")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_FORMS", sequenceName = "SEQ_CNTR_INCOTERM_FORMS", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_FORM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermForms2incotermFormByIncotermFormId"))
    private IncotermForm incotermForm;

    @NotNull
    @Column(name = "F_INCOTERM_FORM_ID", nullable = false)
    private Long incotermFormId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_RULES_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermForms2incotermRulesByIncotermRulesId"))
    private IncotermRules incotermRules;

    @NotNull
    @Column(name = "F_INCOTERM_RULES_ID", nullable = false)
    private Long incotermRulesId;

    @Column(name = "N_ORDER")
    private Byte order;
}
