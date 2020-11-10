package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.ReportField;
import com.nicico.sales.annotation.report.ReportModel;
import com.nicico.sales.model.enumeration.EStatus;
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
public class TozinTableDTO {

    private final Boolean isInView = true;
    @ReportField(titleMessageKey = "Tozin.target.tozin.id")
    private String tozinId;
    private String cardId;
    private String haveCode;
    private String tozinDate;
    @ReportField(titleMessageKey = "Tozin.codeKala")
    private String codeKala;
    @ReportField(titleMessageKey = "Tozin.source")
    private Long sourceId;
    private Long targetId;
    @ReportField(titleMessageKey = "Tozin.vazn")
    private Long vazn;
    //  @ReportField(titleMessageKey = "global.date")
    private String date;
    @ReportField(titleMessageKey = "invoiceSales.otherDescription")
    private String ctrlDescOut;
    @ReportField(titleMessageKey = "Tozin.plak")
    private String plak;
    @ReportField(titleMessageKey = "Tozin.driver")
    private String driverName;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableInfo")
    public static class InfoWithoutRemittanceDetail extends TozinTableDTO {
        private Long id;
        private String containerNo3;

        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
        @ReportModel(type = WarehouseDTO.Info.class, jumpTo = true)
        private WarehouseDTO.Info sourceWarehouse;
        @IgnoreReportField
        private WarehouseDTO.Info targetWarehouse;
        @ReportModel(type = MaterialItemDTO.Info.class, jumpTo = true)
        private MaterialItemDTO.Info materialItem;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableInfo")
    public static class Info extends TozinTableDTO.InfoWithoutRemittanceDetail {
        @IgnoreReportField
        private List<RemittanceDetailDTO.InfoWithoutRemittance> remittanceDetailsAsSource;
        @IgnoreReportField
        private List<RemittanceDetailDTO.InfoWithoutRemittance> remittanceDetailsAsDestination;

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableCreateRq")
    public static class Create extends TozinTableDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableUpdateRq")
    public static class Update extends TozinTableDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinTableDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
