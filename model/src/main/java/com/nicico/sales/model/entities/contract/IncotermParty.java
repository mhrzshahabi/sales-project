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
@Table(name = "TBL_CNTR_INCOTERM_PARTY")
public class IncotermParty extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_PARTY")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_PARTY", sequenceName = "SEQ_CNTR_INCOTERM_PARTY", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_TITLE", nullable = false, length = 200)
    private String title;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;
}
