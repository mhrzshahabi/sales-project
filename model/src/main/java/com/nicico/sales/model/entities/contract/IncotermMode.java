package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_CNTR_INCOTERM_MODE")
public class IncotermMode extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_MODE")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_MODE", sequenceName = "SEQ_CNTR_INCOTERM_MODE", allocationSize = 1)
    private Long id;
}
