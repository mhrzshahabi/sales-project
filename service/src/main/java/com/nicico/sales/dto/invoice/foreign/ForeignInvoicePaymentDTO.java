package com.nicico.sales.dto.invoice.foreign;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.CurrencyRateDTO;
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
public class ForeignInvoicePaymentDTO {

    private String docNo;
    private Date docDate;
    private BigDecimal docSumValue;
    private Date docConversionDate;
    private BigDecimal docConversionRate;
    private BigDecimal docConversionPrice;
    private BigDecimal portion;
    private String description;
    private Long conversionRefId;
    private Long foreignInvoiceId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoicePaymentInfo")
    public static class Info extends ForeignInvoicePaymentDTO {

        private Long id;
        private CurrencyRateDTO.Info conversionRef;
        private ForeignInvoiceDTO.Info foreignInvoice;

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
    @ApiModel("ForeignInvoicePaymentCreateRq")
    public static class Create extends ForeignInvoicePaymentDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoicePaymentUpdateRq")
    public static class Update extends ForeignInvoicePaymentDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoicePaymentDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
