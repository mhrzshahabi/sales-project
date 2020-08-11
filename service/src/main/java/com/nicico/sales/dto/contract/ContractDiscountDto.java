package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;


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


}
