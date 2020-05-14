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
@Table(name = "TBL_CNTR_INCOTERM_PARTIES")
public class IncotermParties extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_PARTIES")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_PARTIES", sequenceName = "SEQ_CNTR_INCOTERM_PARTIES", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermParties2incotermDetailByIncotermDetailId"))
    private IncotermDetail incotermDetail;

    @NotNull
    @Column(name = "F_INCOTERM_DETAIL_ID", nullable = false)
    private Long incotermDetailId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_PARTY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incotermParties2incotermPartyByIncotermPartyId"))
    private IncotermParty incotermParty;

    @NotNull
    @Column(name = "F_INCOTERM_PARTY_ID", nullable = false)
    private Long incotermPartyId;
}
