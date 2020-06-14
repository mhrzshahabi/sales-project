package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_WAREHOUSE")
public class Warehouse2 extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WAREHOUSE")
    @SequenceGenerator(name = "SEQ_WAREHOUSE", sequenceName = "SEQ_WAREHOUSE", allocationSize = 1, initialValue = 100000)
    @Column(name = "ID")
    private Long id;

    @Column(name = "PLANT_ID")
    private Long plantId;

    @NotNull
    @Column(name = "NAME", nullable = false)
    private String name;

    @Column(name = "DESCRIPTION")
    private String description;


}
