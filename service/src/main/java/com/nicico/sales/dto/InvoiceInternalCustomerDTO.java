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
public class InvoiceInternalCustomerDTO {

    private Long id;
    private String customerId;
    private String customerName;
    private String customerAddress;
    private String customerSharh;
    private String customerTel;
    private String customerEghtesadNumber;
    private String customerSabtNumber;
    private String customerPostCode;
    private String customerTelex;
    private String customerFax;
    private String customerCodeNosa;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalCustomerInfo")
    public static class Info extends InvoiceInternalCustomerDTO {
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
    @ApiModel("InvoiceInternalCustomerCreateRq")
    public static class Create extends InvoiceInternalCustomerDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalCustomerUpdateRq")
    public static class Update extends InvoiceInternalCustomerDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalCustomerDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<InvoiceInternalCustomerDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
