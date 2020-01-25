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
public class WarehouseLotDTO {

    private String warehouseNo;
    private Long materialId;
    private String plant;
    private String lotName;
    private Double cu;
    private Double ag;
    private Double au;
    private Double dmt;
    private Double mo;
    private Double si;
    private Double pb;
    private Double s;
    private Double c;
    private String p;
    private String size1;
    private Double size1Value;
    private String size2;
    private Double size2Value;
    private Double weightKg;
    private Double grossWeight;
    private Long contractId;
    private Boolean used;
    private String bookingNo;
    private String typical;
    private Long WarehouseCadItemId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseLotInfo")
    public static class Info extends WarehouseLotDTO {
        private Long id;
        private MaterialDTO.Info material;
        private WarehouseCadItemDTO.Info1 warehouseCadItem;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
        private ContractDTO.ContractInfoTuple contract;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseLotCreateRq")
    public static class Create extends WarehouseLotDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseLotUpdateRq")
    public static class Update extends WarehouseLotDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseLotDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<WarehouseLotDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
