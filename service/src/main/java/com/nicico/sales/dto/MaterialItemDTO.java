package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.ReportField;
import com.nicico.sales.model.entities.warehouse.Inventory;
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
public class MaterialItemDTO {
    @ReportField(titleMessageKey = "MaterialItem.gdsCode")
    private Long gdsCode;
    @ReportField(titleMessageKey = "MaterialItem.gdsName")
    private String gdsName;
    private Long materialId;
    private String miDetailCode;
    private Boolean shouldShowInFilter;
    private String shortName;


    private String gdsNameEN;
    private String gdsNameFA;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialItemInfo")
    public static class Info extends MaterialItemDTO {
        private Long id;
        @IgnoreReportField
        private MaterialDTO material;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialItemInfo")
    public static class InfoWithInventories extends Info {
        private List<InventoryDTO.Info> materialItem;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialItemCreateRq")
    public static class Create extends MaterialItemDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialItemUpdateRq")
    public static class Update extends MaterialItemDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialItemDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
