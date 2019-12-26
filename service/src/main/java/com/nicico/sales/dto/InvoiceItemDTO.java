package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InvoiceItemDTO {

    private Long id;
    @NotNull
    @ApiModelProperty(required = true)
    private Long invoiceId;
    private String upDown;
    private String lessPlus;
    private String description;
    private Double originValue;
    private String originValueCurrency;
    private Double targetValue;
    private String targetValueCurrency;
    private Double conversionRate;
    private String dateRate;
    private String rateReference;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceItemInfo")
    public static class Info extends InvoiceItemDTO {
        private Long id;
        private InvoiceDTO.Info invoice;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceItemCreateRq")
    public static class Create extends InvoiceItemDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceItemUpdateRq")
    public static class Update extends InvoiceItemDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        @NotNull
        @ApiModelProperty(required = true)
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceItemDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("InvoiceItemSpecRs")
    public static class InvoiceItemSpecRs {
        private SpecRs response;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<InvoiceItemDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
