package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.Unit;
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
@Table(name = "TBL_WARH_REMITTANCE_DETAIL")
public class RemittanceDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE_DETAIL")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE_DETAIL", sequenceName = "SEQ_WARH_REMITTANCE_DETAIL", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "N_AMOUNT", nullable = false)
    private Long amount;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_remittanceDetail2unityUnitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_remittanceDetail2remittanceByRemittanceId"))
    private Remittance remittance;

    @NotNull
    @Column(name = "F_REMITTANCE_ID", nullable = false)
    private Long remittanceId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INVENTORY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_remittanceDetail2inventoryByInventoryId"))
    private Inventory inventory;

    @NotNull
    @Column(name = "F_INVENTORY_ID", nullable = false)
    private Long inventoryId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_DEPOT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_remittanceDetail2depotByDepotId"))
    private Depot depot;

    //    @NotNull
    @Column(name = "F_DEPOT_ID", nullable = true)
    private Long depotId;


    //    @NotNull
    @Column(name = "N_VALUE", nullable = true)
    private Long value;


    @OneToMany(mappedBy = "remittanceDetail", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<InventoryValue> inventoryValues;
//
//    @OneToMany(mappedBy = "remittanceDetail", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
//    private List<ItemElement> itemElements;

}
