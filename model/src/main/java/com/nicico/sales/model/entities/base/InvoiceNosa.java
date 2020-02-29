package com.nicico.sales.model.entities.base;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class InvoiceNosa {

    private Long id;
    private String detailName;
    private Long childrenDigitCount;
    private String code;

}
