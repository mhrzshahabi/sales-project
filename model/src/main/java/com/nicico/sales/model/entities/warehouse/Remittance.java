package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.ShipmentType;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_REMITTANCE")
public class Remittance extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE", sequenceName = "SEQ_WARH_REMITTANCE", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_CODE", nullable = false)
    private String code;


    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ITEM_DETAIL_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "fk_remittance2itemByItemDetailId"))
    private ItemDetail itemDetail;

    @NotNull
    @Column(name = "F_ITEM_DETAIL_ID", nullable = false)
    private Long itemId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_TYPE_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "fk_remittance2ShipmentTypeByShipmentTypeId"))
    private ShipmentType shipmentType;

    @NotNull
    @Column(name = "F_SHIPMENT_TYPE_ID", nullable = false)
    private Long shipmentTypeId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SOURCE_WAREHOUSE_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "fk_remittance2warehouseAsSourceByWarehouseId"))
    private Warehouse sourceWarehouse;

    @NotNull
    @Column(name = "F_SOURCE_WAREHOUSE_ID", nullable = false)
    private Long sourceWarehouseId;


    // rahahanPolompNo
    @Column(name = "RAIL_POLOMP_NO")
    private String railPolompNo;

    // herasatPolompNo
    @Column(name = "SECURITY_POLOMP_NO")
    private String securityPolompNo;

    @OneToMany(mappedBy = "remittance", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceDetail> remittanceDetails;

    @OneToMany(mappedBy = "remittance", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @Where(clause = "B_IS_SOURCE_TOZIN = true")
    private List<RemittanceTozin> sourceRemittanceTozin;

    @OneToMany(mappedBy = "remittance", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @Where(clause = "B_IS_SOURCE_TOZIN = false")
    private List<RemittanceTozin> destinationRemittanceTozin;

}