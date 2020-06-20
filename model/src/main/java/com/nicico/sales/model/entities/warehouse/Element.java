package com.nicico.sales.model.entities.warehouse;

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
@Table(name = "TBL_WARH_ELEMENT")
public class Element extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_ELEMENT")
    @SequenceGenerator(name = "SEQ_WARH_ELEMENT", sequenceName = "SEQ_WARH_ELEMENT", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @Column(name = "B_PAYABLE")
    private Boolean payable;

    @Column(name = "B_USE_IN_CONTRACT")
    private Boolean useInContract;

}
