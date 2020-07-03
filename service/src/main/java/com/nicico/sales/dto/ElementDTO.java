package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Currency;
import com.nicico.sales.model.entities.base.Unit;
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
public class ElementDTO {

    private String name;
    private Boolean payable;
    private Boolean useInContract;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ElementInfo")
    public static class Info extends ElementDTO {

        private Long id;

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
    @ApiModel("PriceBaseInfo")
    public static class ElementPriceBaseDTO extends ElementDTO {

        private Long id;
        private String name;
        private Boolean payable;
        private Boolean useInContract;

        private BigDecimal price;

        private Unit unit;
        private Currency currency;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ElementCreateRq")
    public static class Create extends ElementDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ElementUpdateRq")
    public static class Update extends ElementDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ElementDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
