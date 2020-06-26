package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.MaterialItem;
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
@Table(name = "TBL_WARH_MATERIAL_ELEMENT")
public class MaterialElement extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_MATERIAL_ELEMENT")
    @SequenceGenerator(name = "SEQ_WARH_MATERIAL_ELEMENT", sequenceName = "SEQ_WARH_MATERIAL_ELEMENT", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ITEM_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "fk_materialElement2ItemByItemId"))
    private MaterialItem materialItem;

    @NotNull
    @Column(name = "F_MATERIAL_ITEM_ID", nullable = false)
    private Long materialItemId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ELEMENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_itemElement2elementByElementId"))
    private Element element;

    @NotNull
    @Column(name = "F_ELEMENT_ID", nullable = false)
    private Long elementId;


}
