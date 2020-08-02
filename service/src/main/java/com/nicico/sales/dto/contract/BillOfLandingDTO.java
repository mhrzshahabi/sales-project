package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.dto.PortDTO;
import com.nicico.sales.dto.VesselDTO;
import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.model.entities.base.Vessel;
import com.nicico.sales.model.entities.contract.ContainerToBillOfLanding;
import com.nicico.sales.model.entities.contract.RemittanceToBillOfLanding;
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

    private String switchDocumentNo;

    private Long shipperExporterId;

    private Long switchShipperExporterId;

    private Long notifyPartyId;

    private Long switchNotifyPartyId;

    private Long consigneeId;

    private Long switchConsigneeId;

    private Long portOfLoadingId;

    private Long switchPortOfLoadingId;

    private Long portOfDischargeId;

    private Long switchPortOfDischargeId;

    private String placeOfDelivery;

    private Long oceanVesselId;

    private Integer numberOfBlCopies;

    private Date dateOfIssue;

    private String placeOfIssue;

    private String description;

    private String descriptionRemittance;

    private String descriptionContainer;



    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BillOfLandingInfo")
    public static class Info extends BillOfLandingDTO {

        private Long id;

        private ContactDTO.Info shipperExporter;

        private ContactDTO.Info switchShipperExporter;

        private ContactDTO.Info notifyParty;

        private ContactDTO.Info switchNotifyParty;

        private ContactDTO.Info consignee;

        private ContactDTO.Info switchConsignee;

        private PortDTO.Info portOfLoading;

        private PortDTO.Info switchPortOfLoading;

        private PortDTO.Info portOfDischarge;

        private PortDTO.Info switchPortOfDischarge;

        private VesselDTO.Info oceanVessel;

//        private List<RemittanceToBillOfLandingDTO.Info> remittances;

        private List<ContainerToBillOfLandingDTO.Info> containers;





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
