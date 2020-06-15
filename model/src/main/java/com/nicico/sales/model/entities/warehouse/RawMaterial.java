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
@Table(name = "TBL_WARH_RAW_MATERIAL")
public class RawMaterial extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_RAW_MATERIAL")
    @SequenceGenerator(name = "SEQ_WARH_RAW_MATERIAL", sequenceName = "SEQ_WARH_RAW_MATERIAL", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @Column(name = "C_DESCRIPTION", length = 1500)
    private String description;
}
