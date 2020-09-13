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
public class AccountingDTO {

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DepartmentInfo")
    public static class DepartmentInfo {
        private Long id;
        private Long departmentCode;
        private String departmentName;
        private String departmentNameLatin;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DocumentCreateRq")
    public static class DocumentCreateRq {
        private String documentDate;
        private Long department;
        private String documentTitle;
    }
}
