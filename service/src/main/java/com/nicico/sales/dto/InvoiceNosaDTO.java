package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.InvoiceNosa;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.List;

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
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<InvoiceNosaDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }

}
