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
public class AccDepartmentDTO {

    private Long departmentCode;
    private String departmentName;
    private String departmentNameLatin;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("AccDepartmentInfo")
    public static class Info extends AccDepartmentDTO {
        private Long id;
    }
}
