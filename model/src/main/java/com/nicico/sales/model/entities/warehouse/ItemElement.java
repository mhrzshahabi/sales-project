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
@Table(name = "TBL_WARH_ITEM_ELEMENT")
public class ItemElement extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_ITEM_ELEMENT")
    @SequenceGenerator(name = "SEQ_WARH_ITEM_ELEMENT", sequenceName = "SEQ_WARH_ITEM_ELEMENT", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ITEM_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "fk_itemRawMaterial2ItemByItemId"))
    private Item item;

    @NotNull
    @Column(name = "F_ITEM_ID", nullable = false)
    private Long itemId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_itemRawMaterial2rawMaterialByRawMaterialId"))
    private Element element;

    @NotNull
    @Column(name = "F_ELEMENT_ID", nullable = false)
    private Long rawMaterialId;


}
