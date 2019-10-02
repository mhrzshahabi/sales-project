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
@Table(name = "TBL_MATERIAL_FEATURE")
public class MaterialFeature extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_MATERIAL_FEATURE")
	@SequenceGenerator(name = "SEQ_MATERIAL_FEATURE", sequenceName = "SEQ_MATERIAL_FEATURE")
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MATERIAL_ID", nullable = false, insertable = false, updatable = false)
    private Material material;

    @Column(name = "MATERIAL_ID")
    private Long materialId;

    @Column(name = "FEATURE_ROW", nullable = false, length = 5)
    private Long itemRow;


    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FEATURE_ID", nullable = false, insertable = false, updatable = false)
    private Feature feature;

    @Column(name = "FEATURE_ID", nullable = false)
    private Long featureId;

    @Column(name = "MIN_VALUE")
    private Double minValue;

    @Column(name = "MAX_VALUE")
    private Double maxValue;

    @Column(name = "AVG_VALUE")
    private Double avgValue;

    @Column(name = "TOLORANCE")
    private Double tolorance;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RATE_ID", nullable = false, insertable = false, updatable = false)
    private Rate rate;

    @Column(name = "RATE_ID")
    private Long rateId;

    @Column(name = "PAYABLE_IF_GRATER")
    private Double payableIfGraterThan;

    @Column(name = "PAYMENT_PERCENT")
    private Double paymentPercent;

    @Column(name = "TREAT_COST")
    private Double treatCost;

    @Column(name = "REFINERY_COST")
    private Double refineryCost;
}
