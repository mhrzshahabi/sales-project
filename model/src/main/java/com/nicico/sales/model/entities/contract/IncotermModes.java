package com.nicico.sales.model.entities.contract;

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
@Table(name = "TBL_CNTR_INCOTERM_MODES")
public class IncotermModes extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_MODES")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_MODES", sequenceName = "SEQ_CNTR_INCOTERM_MODES", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermModes2incotermByIncotermId"))
    private Incoterm incoterm;

    @NotNull
    @Column(name = "F_INCOTERM_ID", nullable = false)
    private Long incotermId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_MODE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermModes2incotermModeByIncotermModeId"))
    private IncotermMode incotermMode;

    @NotNull
    @Column(name = "F_INCOTERM_MODE_ID", nullable = false)
    private Long incotermModeId;
}