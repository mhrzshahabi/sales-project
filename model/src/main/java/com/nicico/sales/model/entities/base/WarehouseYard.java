package com.nicico.sales.model.entities.base;

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
@Table(name = "TBL_WAREHOUSE_YARD")
public class WarehouseYard extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WAREHOUSE_YARD")
    @SequenceGenerator(name = "SEQ_WAREHOUSE_YARD", sequenceName = "SEQ_WAREHOUSE_YARD", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "WAREHOUSE_NO", length = 20)
    private String warehouseNo;

    @Column(name = "c_NAME_FA", nullable = false)
    private String nameFA;

}
