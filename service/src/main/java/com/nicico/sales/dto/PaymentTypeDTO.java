package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Date;

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

}
