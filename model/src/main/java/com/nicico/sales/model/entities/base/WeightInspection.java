package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.enumeration.InspectionRateValueType;
import com.nicico.sales.model.enumeration.WeighingType;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WEIGHING_INSPECTION")
public class WeightInspection extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WEIGHING_INSPECTION")
    @SequenceGenerator(name = "SEQ_WEIGHING_INSPECTION", sequenceName = "SEQ_WEIGHING_INSPECTION", allocationSize = 1)
    private Long id;

    @Column(name = "C_INSPECTION_NO")
    private String InspectionNO;



    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTOR_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_WeighingInspection2ContactByInspectorId"))
    private Contact contactByInspector;

    @Column(name = "F_INSPECTOR_ID")
    private Long contactByInspectorId;


    @Column(name = "C_INSPECTION_PLACE")
    private String inspectionPlace;

    @Column(name = "D_ISSUE_DATE")
    private Date IssueDate;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "F_SELLER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_WeighingInspection2contactByContactSellerId"))
    private Contact contactBySeller;

    @Column(name = "F_SELLER_ID")
    private Long contactSellerId;


    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "F_BUYER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_WeighingInspection2contactByContactBuyerId"))
    private Contact contactByBuyer;

    @Column(name = "F_BUYER_ID")
    private Long contactBuyerId;


    @Column(name = "N_INSPECTION_RATE_VALUE")
    private BigDecimal inspectionRateValue;


    @Column(name = "N_INSPECTION_RATE_VALUE_TYPE")
    private InspectionRateValueType inspectionRateValueType;


    @Column(name = "N_WEIGHING_TYPE")
    private WeighingType weighingType;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_WAREHOUSE_CAD_ITEM_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_weighingInspection2warehouseCadByWarehouseCadItemId"))
    private WarehouseCadItem warehouseCadItem;

    @NotNull
    @Column(name = "F_WAREHOUSE_CAD_ITEM_ID", nullable = false)
    private Long warehouseCadItemId;


    @Column(name = "N_WEIGHT_G_W")
    private BigDecimal weightGW;


    @Column(name = "N_WEIGHT_N_D")
    private BigDecimal weightND;


    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "F_CURRENCY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_WeighingInspection2currencyById"))
    private Currency currency;

    @NotNull
    @Column(name = "F_CURRENCY_ID", nullable = false)
    private Long currencyById;


}
