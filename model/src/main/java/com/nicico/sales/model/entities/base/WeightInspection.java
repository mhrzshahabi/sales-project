package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
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
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WEIGHING_INSPECTION")
public class WeightInspection extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WEIGHING_INSPECTION")
    @SequenceGenerator(name = "SEQ_WEIGHING_INSPECTION", sequenceName = "SEQ_WEIGHING_INSPECTION", allocationSize = 1)
    private Long id;

    @Column(name = "N_WEIGHING_TYPE")
    private WeighingType weighingType;

    @Column(name = "N_WEIGHT_G_W", scale = 10, precision = 5)
    private BigDecimal weightGW;

    @Column(name = "N_WEIGHT_N_D", scale = 10, precision = 5)
    private BigDecimal weightND;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INSPECTION_REPORT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_weighingInspection2inspectionReportByInspectionReportId"))
    private InspectionReport inspectionReport;

    @NotNull
    @Column(name = "F_INSPECTION_REPORT_ID", nullable = false)
    private Long inspectionReportId;

}