package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.annotation.report.ReportField;
import com.nicico.sales.annotation.report.ReportModel;
import com.nicico.sales.dto.*;
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
public class BillOfLadingSwitchDTO {
    private String documentNo;

    private Long shipperExporterId;

    private Long notifyPartyId;

    private Long consigneeId;

    private Long portOfLoadingId;

    private Long portOfDischargeId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BillOfLandingInfoWithoutShipment")
    public static class Info extends BillOfLadingSwitchDTO {

        private Long id;

        private ContactDTO.Info shipperExporter;

        private ContactDTO.Info notifyParty;

        private ContactDTO.Info consignee;

        private PortDTO.Info portOfLoading;

        private PortDTO.Info portOfDischarge;

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
    @ApiModel("BillOfLandingCreateRq")
    public static class Create extends BillOfLadingSwitchDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BillOfLandingUpdateRq")
    public static class Update extends BillOfLadingSwitchDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BillOfLandingDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
