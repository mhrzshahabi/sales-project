package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InvoiceNosaDTO {

    private Long id;
    private String detailName;
    private Long childrenDigitCount;
    private String code;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceNosaInfo")
    public static class Info extends InvoiceNosaDTO {
    }
}
