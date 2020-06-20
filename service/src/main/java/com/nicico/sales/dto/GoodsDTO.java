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
public class GoodsDTO {
    private String name;
    private Long id;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseInfo")
    public static class Info extends GoodsDTO {
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private String description;
        private Integer version;
    }

}
