package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

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
@Table(name = "TBL_PACKING_LIST")
public class PackingList extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PACKING_LIST")
    @SequenceGenerator(name = "SEQ_PACKING_LIST", sequenceName = "SEQ_PACKING_LIST", allocationSize = 1, initialValue = 100000)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_BILL_OF_LADING",
            foreignKey = @ForeignKey(name = "FK_PACKING_LIST_TO_BILL_OF_LANDING_TO_BL"),
            insertable = false,
            updatable = false
    )
    private BillOfLanding billOfLanding;

    @Column(name = "F_BILL_OF_LADING")
    private Long billOfLandingId;

   @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_SHIPMENT",
            foreignKey = @ForeignKey(name = "FK_PACKING_LIST_TO_SHIPMENT"),
            insertable = false,
            updatable = false
    )
    private Shipment shipment;

    @Column(name = "F_SHIPMENT")
    private Long shipmentId;

    @Column(name="C_BOOKING_NO")
    private String bookingNo;

   @Column(name="C_DESCRIPTION",length = 2000)
    private String description;


}
