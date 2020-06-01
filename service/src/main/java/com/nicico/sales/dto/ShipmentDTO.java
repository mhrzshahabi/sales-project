package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
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

    private Long contactId;
    private Long shipmentHeaderId;
    private Long contractId;
    private Long contractShipmentId;
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
    //@Pattern(regexp = "([12]\\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[12]\\d|3[01]))")
   // @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern="yyyy/MM/dd")
    private Date createDate;
    private String fileName;
    private String newFileName;
    private String shipmentType;
    private String laycan;
    private String switchBl;
    private String swb;
    private Long switchPortId;
    private String noBundle;
    private String noPalete;
    private String noBarrel;
    private String loadingLetter;
    private String blNumbers;
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
    private Double detention;
    private Double demurrage;
    private Double dispatch;
    private long numberOfBLs;
    private Double preFreight;
    private String preFreightCurrency;
    private Double postFreight;
    private String postFreightCurrency;
    private String bookingCat;
    private Long vesselId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentInfo")
    public static class Info extends ShipmentDTO {
        private VesselDTO vessel;
        private ContactDTO.ContactInfoTuple contactByAgent;
        private ContactDTO.ContactInfoTuple contact; // Add By Jalal Buyer
        private ContactDTO.ContactInfoTuple container;
        private PortDTO.PortInfoTuple portByLoading;
        private PortDTO.Info portByDischarge;
        private ContractShipmentDTO contractShipment;
        private PortDTO.PortInfoTuple switchPort;
        private ContractDTO.ContractInfoTuple contract;
        private MaterialDTO.MaterialTuple material;
        private String containerType;
        private Long id;
        private Date createdDate;
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
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentUpdateRq")
    public static class Update extends ShipmentDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
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
