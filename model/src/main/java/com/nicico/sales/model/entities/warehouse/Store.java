package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_STORE")
public class Store extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_STORE")
    @SequenceGenerator(name = "SEQ_WARH_STORE", sequenceName = "SEQ_WARH_STORE", allocationSize = 1)
    private Long id;
//
//    @NotNull
//    @Column(name = "C_CODE", nullable = false)
//    private String code;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @Column(name = "C_DESCRIPTION", length = 1500)
    private String description;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_WAREHOUSE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_store2warehouseByWarehouseId"))
    private Warehouse warehouse;

    @NotNull
    @Column(name = "F_WAREHOUSE_ID", nullable = false)
    private Long warehouseId;

    @OneToMany(mappedBy = "store", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<Depot> depots;
}
