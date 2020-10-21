package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.contract.BillOfLandingDTO;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ShipmentDTO {


    private Long contractShipmentId;
    private Long shipmentTypeId;
    private Long shipmentMethodId;
    private Long contactId;
    private Long materialId;
    private Long contactAgentId;
    private Long vesselId;
    private Long unitId;
    private Long dischargePortId;
    private BigDecimal amount;
    private String description;
    private String containerType;
    private String automationLetterNo;
    private Date automationLetterDate;
    private Date sendDate;
    private Long noBLs;
    private Long noContainer;
    private Long noPackages;
    private String bookingCat;
    private BigDecimal weightGW;
    private BigDecimal weightND;
    private Double vgm;
    private Date arrivalDateFrom;
    private Date arrivalDateTo;
    private Long noPallet;
    private Date lastDeliveryLetterDate;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WithoutBLs")
    public static class InfoWithoutBLs extends ShipmentDTO {
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

        private UnitDTO.Info unit;
        private VesselDTO.Info vessel;
        private ContactDTO.Info contact;
        private PortDTO.Info dischargePort;
        private ContactDTO.Info contactAgent;
        private MaterialDTO.Info material;
        private ShipmentTypeDTO.Info shipmentType;
        private ShipmentMethodDTO.Info shipmentMethod;
        private ContractShipmentDTO.Info contractShipment;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WithoutBLs")
    public static class ShipmentFIInfo extends ShipmentDTO {

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

        private UnitDTO.Info unit;
        private VesselDTO.Info vessel;
        private ContactDTO.Info contact;
        private PortDTO.Info dischargePort;
        private ContactDTO.Info contactAgent;
        private MaterialDTO.Info material;
        private ShipmentTypeDTO.Info shipmentType;
        private ShipmentMethodDTO.Info shipmentMethod;
        private ContractShipmentDTO.ContractShipmentFIInfo contractShipment;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentInfo")
    public static class Info extends InfoWithoutBLs {
        private Set<BillOfLandingDTO.InfoWithoutShipment> bLs;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCreateRq")
    public static class Create extends ShipmentDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentUpdateRq")
    public static class Update extends ShipmentDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

//    @Getter
//    @Setter
//    @Accessors(chain = true)
//    @ApiModel("ShipmentInfoWithContract")
//    public static class InfoWithInvoice extends ShipmentDTO {
//        private List<InvoiceDTO.Info> invoices;
//    }

    public BigDecimal getMoisture(){
        BigDecimal weightGW = getWeightGW();
        BigDecimal weightND = getWeightND();
        if (weightGW == null) weightGW = BigDecimal.ZERO;
        if (weightND == null) weightND = BigDecimal.ZERO;

        return weightGW.subtract(weightND);
    }
}
