package com.nicico.sales.model.entities.contract;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_INCOTERM_STEP")
public class IncotermStep extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_STEP")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_STEP", sequenceName = "SEQ_CNTR_INCOTERM_STEP", allocationSize = 1)
    private Long id;
}