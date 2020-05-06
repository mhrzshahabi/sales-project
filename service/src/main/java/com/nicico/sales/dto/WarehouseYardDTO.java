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
public class WarehouseYardDTO {

    private String warehouseNo;
    private String nameFA;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseYardInfo")
    public static class Info extends WarehouseYardDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseYardCreateRq")
    public static class Create extends WarehouseYardDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseYardUpdateRq")
    public static class Update extends WarehouseYardDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseYardDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
