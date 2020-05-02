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
@Table(name = "TBL_WARH_INVENTORY_RAW_MATERIAL")
public class InventoryRawMaterial extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_INVENTORY_RAW_MATERIAL")
    @SequenceGenerator(name = "SEQ_WARH_INVENTORY_RAW_MATERIAL", sequenceName = "SEQ_WARH_INVENTORY_RAW_MATERIAL", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INVENTORY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventoryRawMaterial2inventoryByInventoryId"))
    private Inventory inventory;

    @NotNull
    @Column(name = "F_INVENTORY_ID", nullable = false)
    private Long inventoryId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_RAW_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventoryRawMaterial2rawMaterialByRawMaterialId"))
    private RawMaterial rawMaterial;

    @NotNull
    @Column(name = "F_RAW_MATERIAL_ID", nullable = false)
    private Long rawMaterialId;
}
