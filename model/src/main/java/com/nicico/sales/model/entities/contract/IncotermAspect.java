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
@Table(name = "TBL_CNTR_INCOTERM_ASPECT")
public class IncotermAspect extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_ASPECT")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_ASPECT", sequenceName = "SEQ_CNTR_INCOTERM_ASPECT", allocationSize = 1)
    private Long id;
}