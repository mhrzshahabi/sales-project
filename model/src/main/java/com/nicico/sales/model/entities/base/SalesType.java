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
@Table(name = "TBL_SALES_TYPE")
public class SalesType extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SALES_TYPE")
    @SequenceGenerator(name = "SEQ_SALES_TYPE", sequenceName = "SEQ_SALES_TYPE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "SALES_TYPE")
    private String salesType;

}
