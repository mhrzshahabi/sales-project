package com.nicico.sales.dto.invoice.foreign;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ForeignInvoiceItemDTO {

    private BigDecimal weightGW;
    private BigDecimal weightND;
    private BigDecimal treatCost;
    private Long foreignInvoiceId;
    private Long remittanceDetailId;
    private InspectionReportMilestone assayMilestone;
    private InspectionReportMilestone weightMilestone;
    private BigDecimal deductionUnitConversionRate;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceItemInfo")
    public static class Info extends ForeignInvoiceItemDTO {

        private Long id;
        private List<ForeignInvoiceItemDetailDTO.Info> foreignInvoiceItemDetails;


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
    @ApiModel("ForeignInvoiceItemCreateRq")
    public static class Create extends ForeignInvoiceItemDTO {

        private List<ForeignInvoiceItemDetailDTO.Create> foreignInvoiceItemDetails;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceItemUpdateRq")
    public static class Update extends ForeignInvoiceItemDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private List<ForeignInvoiceItemDetailDTO.Update> foreignInvoiceItemDetails;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceItemDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("Calc2DataRq")
    public static class Calc2Data {

        private List<FieldData> fields;
        private String priceContent;
        private String quotationalPeriodContent;
        private List<Map<String, Object>> data;
        private List<PriceBaseDTO.Info> priceBase;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @AllArgsConstructor
    @RequiredArgsConstructor
    public static class FieldData {

        private final String name;
        private final String type;
        private final String title;
        private String format;
        private String canEdit;
        private String required;
    }
}
