package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.annotation.I18n;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@I18n
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_SHIPMENT_COST_DUTY")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ShipmentCostDuty extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_COST_DUTY")
    @GenericGenerator(name = "SEQ_COST_DUTY", strategy = "com.nicico.sales.model.entities.common.IdKeepingSequenceGenerator", parameters = {})
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_NAME_FA", nullable = false)
    private String nameFA;

    @NotNull
    @Column(name = "C_NAME_EN", nullable = false)
    private String nameEN;

    @NotNull
    @Column(name = "C_CODE", nullable = false)
    private String code;

    @Column(name = "C_ACC_DETAIL")
    private String accDetail;

    @Column(name = "C_ACC_DETAIL_ID")
    private Long accDetailId;

    @I18n
    @Transient
    private String name;
}
