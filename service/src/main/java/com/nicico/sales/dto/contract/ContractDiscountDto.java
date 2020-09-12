package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;


@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDiscountDto {

    private Long id;
    private Double discount;
    /*  discount contains upperBound */
    private Double upperBound;
    /*  discount does NOT contain lowerBound */
    private Double lowerBound;
    private Long contractId;
    private Long materialElementId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DiscountInfo")
    public static class Info extends ContractDiscountDto {
        private Long id;
        private Date createDate;
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
    @ApiModel("DiscountCreateRq")
    public static class Create extends ContractDiscountDto {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DiscountUpdateRq")
    public static class Update extends ContractDiscountDto {
        @NonNull
        @ApiModelProperty(required = true)
        private Long id;
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
