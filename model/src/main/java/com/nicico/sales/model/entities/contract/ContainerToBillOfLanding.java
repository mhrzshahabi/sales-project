package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

//بارنامه
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CONTAINER_TO_BILL_OF_LANDING")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ContainerToBillOfLanding extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTAINER_TO_BILL_OF_LANDING")
    @SequenceGenerator(name = "SEQ_CONTAINER_TO_BILL_OF_LANDING", sequenceName = "SEQ_CONTAINER_TO_BILL_OF_LANDING", allocationSize = 1, initialValue = 100000)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTAINER_TO_BILL_OF_LANDING_TO_BL",
            foreignKey = @ForeignKey(name = "FK_CONTAINER_TO_BILL_OF_LANDING_TO_BL"),
            insertable = false,
            updatable = false
    )
    private BillOfLanding billOfLanding;

    @NotNull
    @Column(name = "F_CONTAINER_TO_BILL_OF_LANDING_TO_BL", nullable = false)
    private Long billOfLandingId;

    @NotNull
    @Column(name = "C_CONTAINER_ID", nullable = false)
    private String containerType;

     @NotNull
    @Column(name = "C_CONTAINER_NO", nullable = false)
    private String containerNo;

    @NotNull
    @Column(name = "C_SEAL_NO", nullable = false)
    private String sealNo;

    @NotNull
    @Column(name = "D_QUANTITY", nullable = false)
    private Long quantity;

    @NotNull
    @Column(name = "F_QUANTITY_NO", nullable = false)
    private String quantityType;

    @NotNull
    @Column(name = "D_WEIGHT", nullable = false)
    private Long weight;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_CONTAINER_TO_BILL_OF_LANDING_TO_UNIT",
            foreignKey = @ForeignKey(name = "FK_F_CONTAINER_TO_BILL_OF_LANDING_TO_UNIT"),
            insertable = false,
            updatable = false
    )
    private Unit unit;

    @NotNull
    @Column(name = "F_CONTAINER_TO_BILL_OF_LANDING_TO_UNIT", nullable = false)
    private Long unitId;

}
