package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WAREHOUSE_CAD")
public class WarehouseCad extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_WAREHOUSE_CAD")
    @SequenceGenerator(name = "SEQ_WAREHOUSE_CAD", sequenceName = "SEQ_WAREHOUSE_CAD", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "WAREHOUSE_NO")
    private String warehouseNo;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MATERIAL_ITEM_ID", nullable = false, insertable = false, updatable = false)
    private MaterialItem materialItem;

    @Column(name = "MATERIAL_ITEM_ID")
    private Long materialItemId;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "warehouseCad", cascade = CascadeType.ALL)
    private List<WarehouseCadItem> warehouseCadItems;

    @Column(name = "PLANT")
    private String plant;

    @Column(name = "WEIGHT_KG")
    private Double weightKg;

    @Column(name = "BIJACK_NO")
    private String bijackNo;

    @Column(name = "MOVEMENT_TYPE")
    private String movementType;

    @Column(name = "YARD")
    private String yard;

    @Column(name = "SOURCE_LOAD_DATE")
    private String sourceLoadDate;

    @Column(name = "DESTINATION_UNLOAD_DATE")
    private String destinationUnloadDate;

    @Column(name = "CONTAINER_NO")
    private String containerNo;

    @Column(name = "RAHAHAN_POLOMP_NO")
    private String rahahanPolompNo;

    @Column(name = "HERASAT_POLOMP_NO")
    private String herasatPolompNo;

    @Column(name = "SOURCE_BUNDLE_SUM")
    private String sourceBundleSum;

    @Column(name = "DESTINATION_BUNDLE_SUM")
    private String destinationBundleSum;

    @Column(name = "SOURCE_SHEET_SUM")
    private String sourceSheetSum;

    @Column(name = "DESTINATION_SHEET_SUM")
    private String destinationSheetSum;

    @Column(name = "SOURCE_TOZIN_PLANT_ID")
    private String sourceTozinPlantId;

    @Column(name = "DESTINATION_TOZIN_PLANT_ID")
    private String destinationTozinPlantId;

    @Column(name = "SOURCE_WEIGHT")
    private Double sourceWeight;

    @Column(name = "DESTINATION_WEIGHT")
    private Double destinationWeight;
}
