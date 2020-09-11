package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.Inventory;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.model.enumeration.WeighingType;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WEIGHING_INSPECTION", uniqueConstraints = @UniqueConstraint(name = "milestone_inventory_UNIQUE",
        columnNames = {"N_MILESTONE", "F_INVENTORY_ID"}))
public class WeightInspection extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WEIGHING_INSPECTION")
    @SequenceGenerator(name = "SEQ_WEIGHING_INSPECTION", sequenceName = "SEQ_WEIGHING_INSPECTION", allocationSize = 1)
    private Long id;

    @Column(name = "N_WEIGHING_TYPE")
    private WeighingType weighingType;

    @Column(name = "N_WEIGHT_G_W", scale = 5, precision = 10)
    private BigDecimal weightGW;

    @Column(name = "N_WEIGHT_N_D", scale = 5, precision = 10)
    private BigDecimal weightND;

    @NotNull
    @Column(name = "N_MILESTONE", nullable = false)
    private InspectionReportMilestone mileStone;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTION_REPORT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_weighingInspection2inspectionReportByInspectionReportId"))
    private InspectionReport inspectionReport;

    @NotNull
    @Column(name = "F_INSPECTION_REPORT_ID", nullable = false)
    private Long inspectionReportId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_weightInspection2shipmentByShipmentId"))
    private Shipment shipment;

    @NotNull
    @Column(name = "F_SHIPMENT_ID", nullable = false)
    private Long shipmentId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INVENTORY_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_weightInspection2inventoryByInventoryId"))
    private Inventory inventory;

    @NotNull
    @Column(name = "F_INVENTORY_ID", nullable = false)
    private Long inventoryId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_weightInspection2unit"))
    private Unit unit;

    @Column(name = "F_UNIT_ID")
    private Long unitId;

}
