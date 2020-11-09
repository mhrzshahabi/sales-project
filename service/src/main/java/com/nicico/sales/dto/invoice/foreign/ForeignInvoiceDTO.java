package com.nicico.sales.dto.invoice.foreign;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.*;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ForeignInvoiceDTO {

    private String no;
    private Date date;
    private BigDecimal unitPrice;
    private BigDecimal unitCost;
    private BigDecimal sumFIPrice;
    private BigDecimal sumPIPrice;
    private BigDecimal sumPrice;
    private Date conversionDate;
    private BigDecimal conversionRate;
    private BigDecimal conversionSumPrice;
    private String conversionSumPriceText;
    private String description;
    private Long accountingId;
    private Long conversionRefId;
    private Long currencyId;
    private Long buyerId;
    private Long invoiceTypeId;
    private Long shipmentId;
    private Long creatorId;
    private Long parentId;
    private Double percent;
    private Long inspectionWeightReportId;
    private Long inspectionAssayReportId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceInfo")
    public static class Info extends ForeignInvoiceDTO {

        private Long id;
        private CurrencyRateDTO.Info conversionRef;
        private UnitDTO.Info currency;
        private ContactDTO.Info buyer;
        private InvoiceTypeDTO.Info invoiceType;
        private ShipmentDTO.ShipmentFIInfo shipment;
        private PersonDTO.Info creator;
        private InspectionReportDTO.Info inspectionWeightReport;
        private InspectionReportDTO.Info inspectionAssayReport;


        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceCreateRq")
    public static class Create extends ForeignInvoiceDTO {

        private Long contractId;
        private List<Long> billLadingIds;
        private List<ForeignInvoiceItemDTO.Create> foreignInvoiceItems;
        private List<ForeignInvoicePaymentDTO.Create> foreignInvoicePayments;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceUpdateRq")
    public static class Update extends ForeignInvoiceDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private List<Long> billLadingIds;
        private List<ForeignInvoiceItemDTO.Update> foreignInvoiceItems;
        private List<ForeignInvoicePaymentDTO.Update> foreignInvoicePayments;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
