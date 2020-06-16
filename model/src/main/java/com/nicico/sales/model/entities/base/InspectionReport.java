package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.model.enumeration.InspectionRateValueType;
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
@Table(name = "TBL_INSPECTION_REPORT")
public class InspectionReport extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INSPECTION_REPORT")
    @SequenceGenerator(name = "SEQ_INSPECTION_REPORT", sequenceName = "SEQ_INSPECTION_REPORT", allocationSize = 1)
    private Long id;

    @Column(name = "C_INSPECTION_NO")
    private String InspectionNO;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTOR_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2ContactByInspectorId"))
    private Contact inspector;

    @Column(name = "F_INSPECTOR_ID")
    private Long inspectorId;

    @Column(name = "C_INSPECTION_PLACE")
    private String inspectionPlace;

    @Column(name = "D_ISSUE_DATE")
    private Date IssueDate;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_DETAIL_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2RemittanceDetailByRemittanceDetailId"))
    private RemittanceDetail remittanceDetail;

    @NotNull
    @Column(name = "F_REMITTANCE_DETAIL_ID", nullable = false)
    private Long remittanceDetailId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "F_SELLER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2contactBySellerId"))
    private Contact seller;

    @Column(name = "F_SELLER_ID")
    private Long sellerId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "F_BUYER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2contactByBuyerId"))
    private Contact buyer;

    @Column(name = "F_BUYER_ID")
    private Long buyerId;

    @Column(name = "N_INSPECTION_RATE_VALUE", scale = 10, precision = 5)
    private BigDecimal inspectionRateValue;

    @Column(name = "N_INSPECTION_RATE_VALUE_TYPE")
    private InspectionRateValueType inspectionRateValueType;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CURRENCY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inspectionReport2currencyByCurrencyId"))
    private Currency currency;

    @NotNull
    @Column(name = "F_CURRENCY_ID", nullable = false)
    private Long currencyId;

}
