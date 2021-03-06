package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.AssayInspectionTotalValues;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.InspectionRateValueType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InspectionReportDTO {

    private String inspectionNO;
    private Long inspectorId;
    private String inspectionPlace;
    private Date issueDate;
    private Long sellerId;
    private Long buyerId;
    private BigDecimal inspectionRateValue;
    private InspectionRateValueType inspectionRateValueType;
    private String description;
    private Long unitId;
    private BigDecimal weightGW;
    private BigDecimal weightND;
    private List<AssayInspectionTotalValuesDTO.Info> assayInspectionTotalValuesList;
    private List<AssayInspectionDTO.InfoWithoutInspectionReport> assayInspections;
    private List<WeightInspectionDTO.InfoWithoutInspectionReport> weightInspections;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InspectionReportInfo")
    public static class Info extends InspectionReportDTO {

        private Long id;
        private ContactDTO.Info inspector;
        private ContactDTO.Info seller;
        private ContactDTO.Info buyer;
        private UnitDTO.Info unit;

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
    @ApiModel("InspectionReportFIInfo")
    public static class FIInfo extends InspectionReportDTO {

        private Long id;

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
    @ApiModel("InspectionReportCreateRq")
    public static class Create extends InspectionReportDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InspectionReportUpdateRq")
    public static class Update extends InspectionReportDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InspectionReportDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
