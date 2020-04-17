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
public class InvoiceSalesItemDTO {

    private Long id;
    private String productCode;
    private String productName;
    private String unitName;
    private Double netAmount;
    private Double orderAmount;
    private Double unitPrice;
    private Double linePrice;
    private Double discount;
    private Double linePriceAfterDiscount;
    private Double legalFees;
    private Double vat;
    private Double totalPrice;
    private String notes;
    private String explain;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceSalesItemInfo")
    public static class Info extends InvoiceSalesItemDTO {
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
    @ApiModel("InvoiceSalesItemCreateRq")
    public static class Create extends InvoiceSalesItemDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceSalesItemUpdateRq")
    public static class Update extends InvoiceSalesItemDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceSalesItemDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
