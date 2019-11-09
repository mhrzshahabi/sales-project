package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.WarehouseCad;
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
public class WarehouseCadItemDTO {
    private String bundleSerial;
    private String sheetNo;
    private Double weightKg;
    private Double description;

    // ------------------------------

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadItemInfo")
    public static class Info extends WarehouseCadItemDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    // ------------------------------

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadItemCreateRq")
    public static class Create extends WarehouseCadItemDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long warehouseCadId;
    }

    // ------------------------------

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadItemUpdateRq")
    public static class Update extends WarehouseCadItemDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    // ------------------------------

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadItemDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    // ------------------------------

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("WarehouseCadItemSpecRs")
    public static class WarehouseCadItemSpecRs {
        private SpecRs response;
    }

    // ---------------

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<WarehouseCadItemDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}