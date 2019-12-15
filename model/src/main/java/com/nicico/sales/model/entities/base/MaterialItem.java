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
@Table(name = "TBL_MATERIAL_ITEM")
public class MaterialItem extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_MATERIAL_ITEM")
	@SequenceGenerator(name = "SEQ_MATERIAL_ITEM", sequenceName = "SEQ_MATERIAL_ITEM", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "GDSCODE")
    private String gdsCode;

    @Column(name = "GDSNAME")
    private String gdsName;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MATERIAL_ID", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "material_itm2material"))
    private Material material;

    @Column(name = "MATERIAL_ID")
    private Long materialId;

}
