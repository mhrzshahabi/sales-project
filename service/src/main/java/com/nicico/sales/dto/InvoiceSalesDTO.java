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
public class InvoiceSalesDTO {

    private Long id;
    private String serial;
    private String invoiceNo;
    private Date invoiceDate;
    private String district;
    private Long customerId;
    private String customerName;
    private Long salesTypeId;
    private String salesTypeName;
    private String currency;
    private Long contaminationTaxesId;
    private String contaminationTaxesName;
    private Long paymentTypeId;
    private String paymentTypeName;
    private Long lcNoId;
    private String lcNoName;
    private Long preInvoiceId;
    private Date preInvoiceDate;
    private Long issueId;
    private Date issueDate;
    private Long openingBankId;
    private Date openingDate;
    private Long dealerBankId;
    private String dealerBankName;
    private String otherDescription;
    private String firstContractNo;
    private String secondContractNo;
    private String secondContractName;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceSalesInfo")
    public static class Info extends InvoiceSalesDTO {
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
    @ApiModel("InvoiceSalesCreateRq")
    public static class Create extends InvoiceSalesDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceSalesUpdateRq")
    public static class Update extends InvoiceSalesDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceSalesDeleteRq")
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
        private List<InvoiceSalesDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
