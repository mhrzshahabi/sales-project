package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class WarehouseStockDTO {

    private String warehouseNo;
    private String plant;
    private Long warehouseYardId;
    private Long sheet;
    private Long bundle;
    private Double amount;
    private Long barrel;
    private Long lot;
    private Long materialItemId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseStockInfo")
    public static class Info extends WarehouseStockDTO {
        private Long id;
        private MaterialItemDTO materialItem;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseStockCreateRq")
    public static class Create extends WarehouseStockDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseStockUpdateRq")
    public static class Update extends WarehouseStockDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseStockDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
