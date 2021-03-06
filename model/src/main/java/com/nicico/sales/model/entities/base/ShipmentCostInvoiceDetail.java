package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_SHIPMENT_COST_INVOICE_DETAIL")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ShipmentCostInvoiceDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_COST_INVOICE_DETAIL")
    @SequenceGenerator(name = "SEQ_SHIPMENT_COST_INVOICE_DETAIL", sequenceName = "SEQ_SHIPMENT_COST_INVOICE_DETAIL", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "N_QUANTITY", nullable = false)
    private BigDecimal quantity;

    @NotNull
    @Column(name = "N_UNIT_PRICE", nullable = false)
    private BigDecimal unitPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE", nullable = false)
    private BigDecimal sumPrice;

    @NotNull
    @Column(name = "N_DISCOUNT_PRICE", nullable = false)
    private BigDecimal discountPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE_WITH_DISCOUNT", nullable = false)
    private BigDecimal sumPriceWithDiscount;

    @NotNull
    @Column(name = "N_T_VAT_PRICE", nullable = false)
    private BigDecimal tVatPrice;

    @NotNull
    @Column(name = "N_C_VAT_PRICE", nullable = false)
    private BigDecimal cVatPrice;

    @NotNull
    @Column(name = "N_SUM_VAT_PRICE", nullable = false)
    private BigDecimal sumVatPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE_WITH_VAT", nullable = false)
    private BigDecimal sumPriceWithVat;

    ////// References //////

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_COST_INVOICE_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoiceDetail2shipmentCostInvoiceByShipmentCostInvoiceId"))
    private ShipmentCostInvoice shipmentCostInvoice;

    @NotNull
    @Column(name = "F_SHIPMENT_COST_INVOICE_ID", nullable = false)
    private Long shipmentCostInvoiceId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_COST_DUTY_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoiceDetail2shipmentCostDutyId"))
    private ShipmentCostDuty shipmentCostDuty;

    @NotNull
    @Column(name = "F_SHIPMENT_COST_DUTY_ID", nullable = false)
    private Long shipmentCostDutyId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoiceDetail2unitId"))
    private Unit unit;

    @NotNull
    @Column(name = "F_UNIT_ID", nullable = false)
    private Long unitId;

}
