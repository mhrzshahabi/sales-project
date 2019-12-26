package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.model.entities.base.Currency;
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
public class ContractCurrencyDTO {

    private String refrence;
    private Long coefficient;
    private Currency tblCurrency;
    private Long currencyId;
    private Contract contract;
    @NotNull
    @ApiModelProperty(required = true)
    private Long contractId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractCurrencyInfo")
    public static class Info extends ContractCurrencyDTO {
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
    @ApiModel("ContractCurrencyCreateRq")
    public static class Create extends ContractCurrencyDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractCurrencyUpdateRq")
    public static class Update extends ContractCurrencyDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        @NotNull
        @ApiModelProperty(required = true)
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractCurrencyDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("ContractCurrencySpecRs")
    public static class ContractCurrencySpecRs {
        private SpecRs response;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<ContractCurrencyDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
