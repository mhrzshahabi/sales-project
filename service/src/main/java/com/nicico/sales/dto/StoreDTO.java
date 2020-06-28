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
public class StoreDTO {
    private String name;
    private Long warehouseId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("StoreInfo")
    public static class Info extends StoreDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private String description;
        private String name;
        private Integer version;
        private WarehouseDTO.Info warehouse;
    }

}
