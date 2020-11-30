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
public class BillOfLandingDTO {
    private String documentNo;

    private Long shipperExporterId;

    private Long notifyPartyId;

    private Long consigneeId;

    private Long portOfLoadingId;

    private Long portOfDischargeId;

    private String placeOfDelivery;

    private Long oceanVesselId;

    private Integer numberOfBlCopies;

    private Date dateOfIssue;

    private String placeOfIssue;

    private String description;

    private String descriptionRemittance;

    private String descriptionContainer;

    private Integer totalNet;

    private Integer totalGross;

    private Integer totalBundles;

    private Long shipmentId;

    private Long shipmentTypeId;

    private Long shipmentMethodId;

    private Long billOfLadingSwitchId;

    private BillOfLadingSwitchDTO.Info billOfLadingSwitch;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BillOfLandingInfoWithoutShipment")
    public static class InfoWithoutShipment extends BillOfLandingDTO{

        private Long id;

        private ContactDTO.Info shipperExporter;

        private ContactDTO.Info notifyParty;

        private ContactDTO.Info consignee;

        private PortDTO.Info portOfLoading;

        @ReportField(titleMessageKey = "shipment.Bol.tblPortByDischarge")
        @ReportModel(type = PortDTO.Info.class, jumpTo = true)
        private PortDTO.Info portOfDischarge;

        private VesselDTO.Info oceanVessel;

        private List<ContainerToBillOfLandingDTO.Info> containers;
        //        private ShipmentDTO.Info shipment;
        private ShipmentTypeDTO.Info shipmentType;
        private ShipmentMethodDTO.Info shipmentMethod;


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
    @ApiModel("BillOfLandingInfo")
    public static class Info extends InfoWithoutShipment {
        private ShipmentDTO.InfoWithoutBLs shipment;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BillOfLandingCreateRq")
    public static class Create extends BillOfLandingDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BillOfLandingUpdateRq")
    public static class Update extends BillOfLandingDTO {

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
