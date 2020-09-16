package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.enumeration.CurrencyType;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.RateReference;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CurrencyRateDTO {

    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date currencyDate;
    private Long unitFromId;
    private Long unitToId;
    private RateReference reference;
    private BigDecimal currencyRateValue;
    private CurrencyType currencyTypeFrom;
    private CurrencyType currencyTypeTo;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CurrencyRateInfo")
    public static class Info extends CurrencyRateDTO {
        private Long id;
        private Date createdDate;
        private UnitDTO unitFrom;
        private UnitDTO unitTo;
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
    @ApiModel("CurrencyRateCreateRq")
    public static class Create extends CurrencyRateDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CurrencyRateUpdateRq")
    public static class Update extends CurrencyRateDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CurrencyRateDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
