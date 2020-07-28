package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.model.entities.base.Vessel;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.Remittance;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

//بارنامه
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_REMITTANCE_TO_BILL_OF_LANDING")
public class RemittanceToBillOfLanding extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_REMITTANCE_TO_BILL_OF_LANDING")
    @SequenceGenerator(name = "SEQ_REMITTANCE_TO_BILL_OF_LANDING", sequenceName = "SEQ_REMITTANCE_TO_CNTR_BILL_OF_LANDING", allocationSize = 1, initialValue = 100000)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_REMITTANCETOBL_TO_BL",
            foreignKey = @ForeignKey(name = "FK_F_REMITTANCETOBL_TO_BL"),
            insertable = false,
            updatable = false
    )
    private BillOfLanding billOfLanding;

    @NotNull
    @Column(name = "F_REMITTANCETOBL_TO_BL", nullable = false)
    private Long billOfLandingId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(
            name = "F_REMITTANCETOBL_TO_REMITTANCE",
            foreignKey = @ForeignKey(name = "FK_F_REMITTANCETOBL_TO_REMITTANCE"),
            insertable = false,
            updatable = false
    )
    private Remittance remittance;
    
    @NotNull
    @Column(name = "F_REMITTANCETOBL_TO_REMITTANCE")
    private Long remittanceId;

}
