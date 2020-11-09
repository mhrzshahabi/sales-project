package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.annotation.report.ReportField;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Date;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class WarehouseDTO {
    private String name;
    private String shortName;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseInfo")
    public static class Info extends WarehouseDTO {
        private Long id;
        private Long plantId;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private String description;
        private Integer version;
    }

}
