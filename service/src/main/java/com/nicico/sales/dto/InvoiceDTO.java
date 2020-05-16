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
public class InvoiceDTO {

    private Long shipmentId;
    private String invoiceNo;
    private String invoiceDate;
    private String invoiceType;
    private Double net;
    private Double gross;
    private Double unitPrice;
    private String unitPriceCurrency;
    private Double invoiceValue;
    private String invoiceValueCurrency;
    private Double paidPercent;
    private String paidStatus;
    private Double gold;
    private Double silver;
    private Double copper;
    private Double molybdenum;
    private Double molybdenumUnitPrice;
    private Double copperUnitPrice;
    private Double silverUnitPrice;
    private Double goldUnitPrice;
    private Double treatCost;
    private Double refineryCostCU;
    private Double refineryCostAG;
    private Double refineryCostAU;
    private String processId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInfo")
    public static class Info extends InvoiceDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceCreateRq")
    public static class Create extends InvoiceDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceUpdateRq")
    public static class Update extends InvoiceDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
