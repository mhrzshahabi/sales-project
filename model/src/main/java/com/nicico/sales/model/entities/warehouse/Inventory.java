package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Audited
@Entity
@Table(name = "TBL_WARH_INVENTORY")
public class Inventory extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_INVENTORY")
    @SequenceGenerator(name = "SEQ_WARH_INVENTORY", sequenceName = "SEQ_WARH_INVENTORY", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ITEM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventory2itemByItemId"))
    private Item item;

    @NotNull
    @Column(name = "F_ITEM_ID", nullable = false)
    private Long itemId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_WAREHOUSE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventory2warehouseByWarehouseId"))
    private Warehouse warehouse;

    @NotNull
    @Column(name = "F_WAREHOUSE_ID", nullable = false)
    private Long warehouseId;

    @OneToMany(mappedBy = "inventory", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<InventoryValue> inventoryValues;

    @OneToMany(mappedBy = "inventory", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<InventoryRawMaterial> inventoryRawMaterials;
}
