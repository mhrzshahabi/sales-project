package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.copper.common.dto.date.DateTimeDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ShipmentDTO {

    private Long contractShipmentId;
    private Long contactId;
    private Long contractId;
    private Long materialId;
    private Double amount;
    private Long noContainer;
    private String containerType;
    private Long portByLoadingId;
    private Long portByDischargeId;
    private String dischargeAddress;
    private String description;
    private String status;
    private String month;
    private String fileName;
    private String newFileName;
    private String shipmentType;
    private String shipmentMethod;
    private String laycan;
    private String switchBl;
    private String swb;
    private Long switchPortId;
    private Integer noBundle;
    private String loadingLetter;
    private String blNumbers;
    private Long numberOfBLs;
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date blDate;
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date swBlDate;
    private String consignee;
    private Long contactByAgentId;
    private Double freight;
    private Double totalFreight;
    private String freightCurrency;
    private Double preFreight;
    private String preFreightCurrency;
    private Double postFreight;
    private String postFreightCurrency;
    private Long noBarrel;
    private Long noPalete;
    private Double demurrage;
    private Double dispatch;
    private Double detention;
    private String bookingCat;
    private Long vesselId;
    private Double gross;
    private Double net;
    private Double moisture;
    private Double vgm;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentInfo")
    public static class Info extends ShipmentDTO {
        private Long id;
        private VesselDTO vessel;
        private ContactDTO.ContactInfoTuple contactByAgent;
        private ContactDTO.ContactInfoTuple contact;
        private ContactDTO.ContactInfoTuple container;
        private PortDTO.PortInfoTuple portByLoading;
        private PortDTO.Info portByDischarge;
        private ContractShipmentDTO contractShipment;
        private PortDTO.PortInfoTuple switchPort;
        private ContractDTO.ContractInfoTuple contract;
        private MaterialDTO.MaterialTuple material;
        private String containerType;
        private DateTimeDTO.DateTimeStrRs createDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentCreateRq")
    public static class Create extends ShipmentDTO {
        private DateTimeDTO.DateTimeStrRq createDate;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentUpdateRq")
    public static class Update extends ShipmentDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private DateTimeDTO.DateTimeStrRq createDate;
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

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentInfoWithContract")
    public static class InfoWithInvoice extends ShipmentDTO {
        private List<InvoiceDTO.Info> invoices;
    }

}
