package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Contact;
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
@Table(name = "TBL_CNTR_INCOTERM_CONTACT")
public class IncotermContact extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_CONTACT")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_CONTACT", sequenceName = "SEQ_CNTR_INCOTERM_CONTACT", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_TERM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermContact2termByTermId"))
    private Term term;

    @Column(name = "F_TERM_ID")
    private Long termId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_ASPECT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermContact2incotermAspectByIncotermAspectId"))
    private IncotermAspect incotermAspect;

    @NotNull
    @Column(name = "F_INCOTERM_ASPECT_ID", nullable = false)
    private Long incotermAspectId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermContact2contactByContactId"))
    private Contact contact;

    @NotNull
    @Column(name = "F_CONTACT_ID", nullable = false)
    private Long contactId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_STEPS_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermContact2incotermStepsByIncotermStepsId"))
    private IncotermSteps incotermSteps;

    @NotNull
    @Column(name = "F_INCOTERM_STEPS_ID", nullable = false)
    private Long incotermStepsId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_MODES_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermContact2incotermModesByIncotermModesId"))
    private IncotermModes incotermModes;

    @NotNull
    @Column(name = "F_INCOTERM_MODES_ID", nullable = false)
    private Long incotermModesId;
}