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
public class WarehouseCadDTO {
    private String warehouseNo;
    private Long materialItemId;
    private String plant;
    private Double weightKg;
    private String bijackNo;
    private String movementType;
    private Long warehouseYardId;
    private String sourceLoadDate;
    private String destinationUnloadDate;
    private String containerNo;
    private String rahahanPolompNo;
    private String herasatPolompNo;
    private Integer sourceBundleSum;
    private Integer destinationBundleSum;
    private Integer sourceSheetSum;
    private Integer destinationSheetSum;
    private String sourceTozinPlantId;
    private String destinationTozinPlantId;
    private Double sourceWeight;
    private Double destinationWeight;



    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadInfo")
    public static class Info extends WarehouseCadDTO {
        private Long id;
        private List<WarehouseCadItemDTO.Info> warehouseCadItems;
        private MaterialItemDTO materialItem;
        private WarehouseYardDTO warehouseYard;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }
    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadInfoCombo")
    public static class InfoCombo  {
        private Long id;
        private String bijackNo;
        private List<WarehouseCadItemDTO.InfoCombo> warehouseCadItems;
        private WarehouseYardDTO warehouseYard;
    }

   @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadInfoCombo2")
    public static class InfoCombo2  {
        private Long id;
        private String bijackNo;
    }




    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadCreateRq")
    public static class Create extends WarehouseCadDTO {
        private List<WarehouseCadItemDTO.Create> warehouseCadItems;
    }



    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadUpdateRq")
    public static class Update extends WarehouseCadDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }



    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseCadDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }



    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("WarehouseCadSpecRs")
    public static class WarehouseCadSpecRs {
        private SpecRs response;
    }

    // ---------------

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<WarehouseCadDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
