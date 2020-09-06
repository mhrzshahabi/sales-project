package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

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

    @NotBlank
    @Column(name = "GDSNAME")
    private String gdsName;

    @Column(name = "C_GDSNAME_EN")
    private String gdsNameEn;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "material_itm2material"))
    private Material material;

    @Column(name = "MATERIAL_ID")
    private Long materialId;

    @Column(name = "MI_DETAIL_CODE")
    private String miDetailCode;

    @Column(name = "C_ACC_DETAIL")
    private String accDetail;

    @Column(name = "C_ACC_DETAIL_ID")
    private Long accDetailId;
}
