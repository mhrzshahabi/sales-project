package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.SymbolCurrency;
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
public class CurrencyDTO {

    private String nameFa;
    private String nameEn;
    private String isActive;
    private SymbolCurrency symbolCurrency;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CurrencyInfo")
    public static class Info extends CurrencyDTO {

        private Long id;
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
    @ApiModel("CurrencyCreateRq")
    public static class Create extends CurrencyDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CurrencyUpdateRq")
    public static class Update extends CurrencyDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CurrencyDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
