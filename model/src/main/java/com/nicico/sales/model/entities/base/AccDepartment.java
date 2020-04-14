package com.nicico.sales.model.entities.base;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AccDepartment {

    private Long departmentCode;
    private String departmentName;
    private String departmentNameLatin;

}
