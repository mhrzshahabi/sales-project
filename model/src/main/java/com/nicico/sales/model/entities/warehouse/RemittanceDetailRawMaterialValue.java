package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_REMITTANCE_DETAIL_RAW_MATERIAL_VALUE")
public class RemittanceDetailRawMaterialValue extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE_DETAIL_RAW_MATERIAL_VALUE")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE_DETAIL_RAW_MATERIAL_VALUE", sequenceName = "SEQ_WARH_REMITTANCE_DETAIL_RAW_MATERIAL_VALUE", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_CODE", nullable = false)
    private String code;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ITEM_RAW_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventoryRawMaterialValue2itemRawMaterialByInventoryRawMaterialId"))
    private ItemRawMaterial itemRawMaterial;

    @NotNull
    @Column(name = "F_ITEM_RAW_MATERIAL_ID", nullable = false)
    private Long itemRawMaterialId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventoryRawMaterialValue2unitByUnitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventoryRawMaterialValue2contactByContactId"))
    private Contact contact;

    @NotNull
    @Column(name = "F_CONTACT_ID", nullable = false)
    private Long contactId;

     @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventoryRawMaterialValue2remittanceDetailByremittanceDetailId"))
    private RemittanceDetail remittanceDetail;

    @NotNull
    @Column(name = "F_REMITTANCE_DETAIL_ID", nullable = false)
    private Long remittanceDetailId;


}
