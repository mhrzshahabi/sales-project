package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.MaterialElementDTO;
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
public class ContractDiscountDTO {

    private BigDecimal discount;
    /*  discount contains upperBound */
    private BigDecimal upperBound;
    /*  discount does NOT contain lowerBound */
    private BigDecimal lowerBound;
    private Long contractId;
    private Long materialElementId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DiscountInfo")
    public static class Info extends ContractDiscountDTO {
        private Long id;
        private Date createDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        private MaterialElementDTO.Info materialElement;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DiscountCreateRq")
    public static class Create extends ContractDiscountDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DiscountUpdateRq")
    public static class Update extends ContractDiscountDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DiscountDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
