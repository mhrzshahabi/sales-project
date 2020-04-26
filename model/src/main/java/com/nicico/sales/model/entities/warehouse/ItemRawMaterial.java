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
@Table(name = "TBL_WARH_ITEM_RAW_MATERIAL")
public class ItemRawMaterial extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_ITEM_RAW_MATERIAL")
    @SequenceGenerator(name = "SEQ_WARH_ITEM_RAW_MATERIAL", sequenceName = "SEQ_WARH_ITEM_RAW_MATERIAL", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ITEM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_itemRawMaterial2inventoryByInventoryId"))
    private Item item;

    @NotNull
    @Column(name = "F_ITEM_ID", nullable = false)
    private Long itemId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_RAW_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_itemRawMaterial2rawMaterialByRawMaterialId"))
    private RawMaterial rawMaterial;

    @NotNull
    @Column(name = "F_RAW_MATERIAL_ID", nullable = false)
    private Long rawMaterialId;
}
