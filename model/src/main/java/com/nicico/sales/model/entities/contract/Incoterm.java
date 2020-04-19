package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_INCOTERM")
public class Incoterm extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM", sequenceName = "SEQ_CNTR_INCOTERM", allocationSize = 1)
    private Long id;

    @OneToMany(mappedBy = "incoterm", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<IncotermModes> incotermModes;

    @OneToMany(mappedBy = "incoterm", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<IncotermSteps> incotermSteps;
}
