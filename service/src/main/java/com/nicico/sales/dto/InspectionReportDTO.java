package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
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

    private String InspectionNO;
    private Long inspectorId;
    private String inspectionPlace;
    private Date IssueDate;
    private Long remittanceDetailId;
    private Long sellerId;
    private Long buyerId;
    private BigDecimal inspectionRateValue;
    private InspectionRateValueType inspectionRateValueType;
    private Long currencyId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InspectionReportInfo")
    public static class Info extends InspectionReportDTO {

        private Long id;
        private ContactDTO.Info inspector;
        private RemittanceDetailDTO.Info remittanceDetail;
        private ContactDTO.Info seller;
        private ContactDTO.Info buyer;
        private CurrencyDTO.Info currency;

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
