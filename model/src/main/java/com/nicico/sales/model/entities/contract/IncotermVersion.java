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
@Table(name = "TBL_CNTR_INCOTERM_VERSION")
public class IncotermVersion extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM_VERSION")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM_VERSION", sequenceName = "SEQ_CNTR_INCOTERM_VERSION", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "N_INCOTERM_VERSION", nullable = false, unique = true)
    private Integer incotermVersion;

}
