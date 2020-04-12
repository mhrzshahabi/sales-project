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
@Table(name = "TBL_CNTR_TERM")
public class Term extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_TERM")
    @SequenceGenerator(name = "SEQ_CNTR_TERM", sequenceName = "SEQ_CNTR_TERM", allocationSize = 1)
    private Long id;
}