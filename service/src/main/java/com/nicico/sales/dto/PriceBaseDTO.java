package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.PriceBaseReference;
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
public class PriceBaseDTO {

    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date priceDate;
    private Long elementId;
    private PriceBaseReference priceBaseReference;
    private BigDecimal price;
    private Long weightUnitId;
    private Long financeUnitId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PriceBaseInfo")
    public static class Info extends PriceBaseDTO {
        private Long id;
        private ElementDTO.Info element;
        private UnitDTO.Info weightUnit;
        private UnitDTO.Info financeUnit;

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
    @ApiModel("PriceBaseCreateRq")
    public static class Create extends PriceBaseDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PriceBaseUpdateRq")
    public static class Update extends PriceBaseDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PriceBaseDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
