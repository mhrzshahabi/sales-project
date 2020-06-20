package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_GOODS")
public class Goods extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_GOODS")
    @SequenceGenerator(name = "SEQ_GOODS", sequenceName = "SEQ_GOODS", allocationSize = 1, initialValue = 100000)
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_NAME_FA", length = 1000)
    private String name;

}
