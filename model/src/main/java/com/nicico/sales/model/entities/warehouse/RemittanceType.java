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
@Table(name = "TBL_WARH_REMITTANCE_TYPE")
public class RemittanceType extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE_TYPE")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE_TYPE", sequenceName = "SEQ_WARH_REMITTANCE_TYPE", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @Column(name = "C_DESCRIPTION", length = 1500)
    private String description;

    @Column(name = "C_CONDITION", length = 1500, nullable = true)
    private String condition;


}
