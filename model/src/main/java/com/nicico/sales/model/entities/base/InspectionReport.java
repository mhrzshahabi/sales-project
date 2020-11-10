package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.InspectionRateValueType;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_INSPECTION_REPORT")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class InspectionReport extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INSPECTION_REPORT")
    @SequenceGenerator(name = "SEQ_INSPECTION_REPORT", sequenceName = "SEQ_INSPECTION_REPORT", allocationSize = 1)
    private Long id;

    @Column(name = "C_INSPECTION_NO")
    private String inspectionNO;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTOR_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2ContactByInspectorId"))
    private Contact inspector;

    @Column(name = "F_INSPECTOR_ID")
    private Long inspectorId;

    @Column(name = "C_INSPECTION_PLACE")
    private String inspectionPlace;

    @Column(name = "D_ISSUE_DATE")
    private Date issueDate;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SELLER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2contactBySellerId"))
    private Contact seller;

    @Column(name = "F_SELLER_ID")
    private Long sellerId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_BUYER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2contactByBuyerId"))
    private Contact buyer;

    @Column(name = "F_BUYER_ID")
    private Long buyerId;

    @Column(name = "N_INSPECTION_RATE_VALUE", scale = 5, precision = 10)
    private BigDecimal inspectionRateValue;

    @Column(name = "N_INSPECTION_RATE_VALUE_TYPE")
    private InspectionRateValueType inspectionRateValueType;

    @Column(name = "C_DESCRIPTION")
    private String description;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2unitByUnitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

    @Column(name = "N_WEIGHT_G_W", scale = 5, precision = 10)
    private BigDecimal weightGW;

    @Column(name = "N_WEIGHT_N_D", scale = 5, precision = 10)
    private BigDecimal weightND;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "inspectionReport", cascade = CascadeType.REMOVE)
    private List<AssayInspectionTotalValues> assayInspectionTotalValuesList;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "inspectionReport", cascade = CascadeType.REMOVE)
    private List<AssayInspection> assayInspections;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "inspectionReport", cascade = CascadeType.REMOVE)
    private List<WeightInspection> weightInspections;

}
