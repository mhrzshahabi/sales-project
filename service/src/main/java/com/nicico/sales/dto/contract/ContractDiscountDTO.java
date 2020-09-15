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
public class ContractDiscountDTO {

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
    public static class Info extends ContractDiscountDTO {
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
    public static class Create extends ContractDiscountDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DiscountUpdateRq")
    public static class Update extends ContractDiscountDTO {
        @NonNull
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
