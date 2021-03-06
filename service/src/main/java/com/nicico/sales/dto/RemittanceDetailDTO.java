package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.ReportField;
import com.nicico.sales.annotation.report.ReportModel;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RemittanceDetailDTO {

    @ReportField(titleMessageKey = "global.amount")
    private Long amount;
    private Long unitId;
    private Long remittanceId;
    private Long depotId;
    private String railPolompNo;
    private String securityPolompNo;
    @ReportField(titleMessageKey = "remittance.detail.weight")
    private Long weight;
    @ReportField(titleMessageKey = "global.description")
    private String description;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailInfo")
    public static class InfoWithoutRemittance extends RemittanceDetailDTO {

        private Long id;
        @IgnoreReportField
        private UnitDTO.Info unit;
        @IgnoreReportField
        private TozinTableDTO.InfoWithoutRemittanceDetail sourceTozin;
        @IgnoreReportField
        private TozinTableDTO.InfoWithoutRemittanceDetail destinationTozin;
        @IgnoreReportField
        private InventoryDTO.InfoWithoutRemittanceDetail inventory;
        @IgnoreReportField
        private DepotDTO.Info depot;
        @ReportField(titleMessageKey = "remittance.detail.date")
        private String date;
        private Boolean inputRemittance;

//        private Remittance remittance;


        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailInfo")
    public static class InfoWithoutRemittanceInspections extends RemittanceDetailDTO {

        private Long id;
        private UnitDTO.Info unit;
        private TozinTableDTO.InfoWithoutRemittanceDetail sourceTozin;
        private TozinTableDTO.InfoWithoutRemittanceDetail destinationTozin;
        private InventoryDTO.InfoWithInspections inventory;
        private DepotDTO.Info depot;
//        private Remittance remittance;


        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailInfo")
    public static class Info extends InfoWithoutRemittance {
        private RemittanceDTO.InfoWithoutRemittanceDetail remittance;
        private TozinTableDTO.InfoWithoutRemittanceDetail tozin;

        public String getInventoryLabel() {

            InventoryDTO.InfoWithoutRemittanceDetail inventory = getInventory();
            if (inventory == null) return "";
            return inventory.getLabel();
        }
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailReportInfo")
    public static class ReportInfo extends InfoWithoutRemittance {

        @ReportModel(type = RemittanceDTO.ReportInfo.class, jumpTo = true)
        private RemittanceDTO.ReportInfo remittance;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailCreateRq")
    public static class Create extends RemittanceDetailDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailUpdateRq")
    public static class Update extends RemittanceDetailDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    public static class WithInventory extends RemittanceDetailDTO {
        InventoryDTO.Create inventory;
        TozinTableDTO.Create sourceTozin;
        TozinTableDTO.Create destinationTozin;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    public static class WithRemittanceAndInventory {
        private RemittanceDTO.Create remittance;
        private List<RemittanceDetailDTO.WithInventory> remittanceDetails;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    public static class OutCreate extends RemittanceDetailDTO {
        Long inventoryId;
        TozinTableDTO.Create sourceTozin;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    public static class OutRemittance {
        private RemittanceDTO.Create remittance;
        @NotEmpty
        @NotNull
        private List<RemittanceDetailDTO.OutCreate> remittanceDetails;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    public static class Excel {
        public List<RemittanceDetailDTO.Info> rows;
        public String[] header;
        public String topRowTitle;
        public String[] fields;
        public NICICOCriteria nicicoCriteria;
        public Boolean doesNotNeedFetch = true;
    }
    @Getter
    @Setter
    @Accessors(chain = true)
    public static class OutRemittanceWeight {
        public RemittanceDTO.Create remittance;
        public TozinTableDTO.Create tozin;
        public List<Long> sourceList;
        public  Long targetId;
    }



}
