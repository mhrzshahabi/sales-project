package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.annotation.I18n;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.Inventory;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.List;

@I18n
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_MATERIAL_ITEM")
public class MaterialItem extends BaseEntity {

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_MATERIAL_ITEM")
//    @SequenceGenerator(name = "SEQ_MATERIAL_ITEM", sequenceName = "SEQ_MATERIAL_ITEM", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "GDSCODE")
    private Long gdsCode;

    @Column(name = "B_SHOULD_SHOW_IN_FILTER")
    private Boolean shouldShowInFilter;

    @NotBlank
    @Column(name = "GDSNAME")
    private String gdsNameFA;

    @I18n
    @Transient
    private String gdsName;


    @Column(name = "c_short_name")
    private String shortName;

    @Column(name = "C_GDSNAME_EN")
    private String gdsNameEN;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "material_itm2material"))
    private Material material;

    @Column(name = "MATERIAL_ID")
    private Long materialId;

    @Column(name = "MI_DETAIL_CODE")
    private String miDetailCode;

    @OneToMany(mappedBy = "materialItem", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<Inventory> materialItem;

}
