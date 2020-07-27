package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import net.jcip.annotations.NotThreadSafe;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_SHIPMENT_COST_INVOICE_DETAIL")
public class ShipmentCostInvoiceDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_COST_INVOICE_DETAIL")
    @SequenceGenerator(name = "SEQ_SHIPMENT_COST_INVOICE_DETAIL", sequenceName = "SEQ_SHIPMENT_COST_INVOICE_DETAIL", allocationSize = 1)
    private Long id;

    @Column(name = "C_SERVICE_CODE")
    private String serviceCode;

    @NotNull
    @Column(name = "C_SERVICE_NAME", nullable = false)
    private String serviceName;

    @NotNull
    @Column(name = "N_QUANTITY", nullable = false, scale = 5, precision = 10)
    private BigDecimal quantity;

    @NotNull
    @Column(name = "N_UNIT_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal unitPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal sumPrice;

    @NotNull
    @Column(name = "N_DISCOUNT_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal discountPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE_WITH_DISCOUNT", nullable = false, scale = 6, precision = 18)
    private BigDecimal sumPriceWithDiscount;

    @NotNull
    @Column(name = "N_T_VAT_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal tVatPrice;

    @NotNull
    @Column(name = "N_C_VAT_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal cVatPrice;

    @NotNull
    @Column(name = "N_SUM_VAT_PRICE", nullable = false, scale = 6, precision = 18)
    private BigDecimal sumVatPrice;

    @NotNull
    @Column(name = "N_SUM_PRICE_WITH_VAT", nullable = false, scale = 6, precision = 18)
    private BigDecimal sumPriceWithVat;

    ////// References //////

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_SHIPMENT_COST_INVOICE_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_shipmentCostInvoiceDetail2shipmentCostInvoiceByShipmentCostInvoiceId"))
    private ShipmentCostInvoice shipmentCostInvoice;

    @NotNull
    @Column(name = "F_SHIPMENT_COST_INVOICE_ID", nullable = false)
    private Long shipmentCostInvoiceId;

}
