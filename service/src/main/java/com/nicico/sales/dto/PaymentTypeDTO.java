package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
public class PaymentTypeDTO {

    private Long id;
    private Long code;
    private String paymentType;
    private Boolean nonCash;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PaymentTypeInfo")
    public static class Info extends PaymentTypeDTO {
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
    @ApiModel("PaymentTypeCreateRq")
    public static class Create extends PaymentTypeDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PaymentTypeUpdateRq")
    public static class Update extends PaymentTypeDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PaymentTypeDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
