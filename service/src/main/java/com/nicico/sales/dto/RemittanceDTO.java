package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.ReportField;
import com.nicico.sales.annotation.report.ReportModel;
import com.nicico.sales.model.entities.warehouse.TozinTable;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RemittanceDTO {

    private String code;
    @ReportField(titleMessageKey = "global.description", canFilter = false, hidden = true)
    private String description;
    @IgnoreReportField
    private Long shipmentId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceInfo")
    public static class InfoWithoutRemittanceDetail extends RemittanceDTO {

        private Long id;
        @ReportModel(type = MaterialItemDTO.Info.class)
        private MaterialItemDTO.Info materialItem;
        @ReportModel(type = MaterialItemDTO.Info.class)
        private MaterialItemDTO.Info shipment;
        private String date;
        @ReportModel(type = TozinTableDTO.Info.class)
        private TozinTableDTO.Info tozinTable;


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
    @ApiModel("RemittanceInfo")
    public static class Info extends RemittanceDTO.InfoWithoutRemittanceDetail {

        @IgnoreReportField
        private List<RemittanceDetailDTO.InfoWithoutRemittance> remittanceDetails;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceInfo")
    public static class InfoWithInspections extends RemittanceDTO.InfoWithoutRemittanceDetail {
        private List<RemittanceDetailDTO.InfoWithoutRemittanceInspections> remittanceDetails;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceCreateRq")
    public static class Create extends RemittanceDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceUpdateRq")
    public static class Update extends RemittanceDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Setter
    @Getter
    @NoArgsConstructor
    public static class PDF extends Info {
        String depot;
        String materialItemName;
        Boolean isWithRail;
        String from;
        String sourceDate;
        String destinationDate;
    }
}
