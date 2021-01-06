package com.nicico.sales.dto.invoice.foreign;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.MaterialElementDTO;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.model.enumeration.DeductionType;
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
public class ForeignInvoiceItemDetailDTO {

    private BigDecimal assay;
    private BigDecimal basePrice;
    private BigDecimal rcPrice;
    private BigDecimal rcBasePrice;
    private BigDecimal rcUnitConversionRate;
    private DeductionType deductionType;
    private BigDecimal deductionValue;
    private BigDecimal deductionUnitConversionRate;
    private BigDecimal deductionPrice;
    private Long foreignInvoiceItemId;
    private Long materialElementId;
    private Long basePriceFinanceUnitId;
    private Long basePriceWeightUnitId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceItemDetailInfo")
    public static class Info extends ForeignInvoiceItemDetailDTO {

        private Long id;
        private UnitDTO.Info basePriceWeightUnit;
        private UnitDTO.Info basePriceFinanceUnit;
        private MaterialElementDTO.Info materialElement;

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
    @ApiModel("ForeignInvoiceItemDetailCreateRq")
    public static class Create extends ForeignInvoiceItemDetailDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceItemDetailUpdateRq")
    public static class Update extends ForeignInvoiceItemDetailDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceItemDetailDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
