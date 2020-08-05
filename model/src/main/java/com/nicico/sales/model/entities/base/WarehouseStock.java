package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_WAREHOUSE_STOCK")
public class WarehouseStock extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WAREHOUSE_STOCK")
    @SequenceGenerator(name = "SEQ_WAREHOUSE_STOCK", sequenceName = "SEQ_WAREHOUSE_STOCK", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "WAREHOUSE_NO")
    private String warehouseNo;

    @Column(name = "PLANT")
    private String plant;

    @Column(name = "YARD_ID")
    private Long warehouseYardId;

    @Column(name = "SHEET")
    private Long sheet;

    @Column(name = "BUNDLE")
    private Long bundle;

    @Column(name = "AMOUNT")
    private Double amount;

    @Column(name = "BARREL")
    private Long barrel;

    @Column(name = "LOT")
    private Long lot;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MATERIAL_ITEM_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "WarehouseStock2matherialitem"))
    private MaterialItem materialItem;

    @Column(name = "MATERIAL_ITEM_ID")
    private Long materialItemId;

}
