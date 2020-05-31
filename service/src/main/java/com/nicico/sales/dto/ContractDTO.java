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
public class ContractDTO {

    private String contractNo;
    private String contractDate;
    private String isComplete;
    private String incotermsText;
    private String officeSource;
    private String priceCalPeriod;
    private String publishTime;
    private String reportTitle;
    private String delay;
    private String payTime;
    private String pricePeriod;
    private String eventPayment;
    private String contentType;
    private String amount_en;
    private String prefixPayment;
    private Long incotermsId;
    private Long prepaid;
    private Long portByPortSourceId;
    private String prepaidCurrency;
    private String runFrom;
    private String runStartDate;
    private String runEndtDate;
    private String runTill;
    private Long materialId;
    private Double amount;
    private Long unitId;
    private Double premium;
    private Double discount;
    private Double treatCost;
    private Double refinaryCost;
    private Double gold;
    private Double goldTolorance;
    private Double silver;
    private Double silverTolorance;
    private Double copper;
    private Double copperTolorance;
    private Double molybdenum;
    private Double molybdenumTolorance;
    private String sideContractNo;
    private String sideContractDate;
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date contractStart;
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date contractEnd;
    private String timeIssuance;
    private String invoiceType;
    private Integer optional;
    private long contactInspectionId;
    private Double mo_amount;
    private Long contactId; // contactByBuyerId
    private Long contactByBuyerAgentId;
    private Long contactBySellerId;
    private Long contactBySellerAgentId;


    @Getter
    @Setter
    @ApiModel("ContractInfoTuple")
    public static class ContractInfoTuple {
        private String contractNo;
        private String id;
        private String contractDate;
        private ContactDTO.ContactInfoTuple contact;
        private ContactDTO.ContactInfoTuple contactBySeller;
        private ContactDTO.ContactInfoTuple contactBySellerAgent;
        private ContactDTO.ContactInfoTuple contactByBuyerAgent;
        private PortDTO.Info portByPortSource;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractInfo")
    public static class Info extends ContractDTO {
        private UnitDTO unit;
        private MaterialDTO material;
        private IncotermsDTO incoterms;
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
        private ContactDTO contact;
        private ContactDTO contactBySeller;
        private ContactDTO contactBySellerAgent;
        private ContactDTO contactByBuyerAgent;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractCreateRq")
    public static class Create extends ContractDTO {
        private ContractDetailDTO.Create contractDetails;
        private List<ContractShipmentDTO.Create> contractShipments;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractUpdateRq")
    public static class Update extends ContractDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private ContractDetailDTO.Update contractDetails;
        private List<ContractShipmentDTO.Update> contractShipments;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractInfo")
    public static class InfoForReport extends ContractDTO {
        private UnitDTO unit;
        private MaterialDTO material;
        private Long id;
        private ContactDTO contact;
        private List<ShipmentDTO.InfoWithInvoice> shipments;
        private String year;

        public String getYear() {
            final String contractDate = this.getContractDate();
            try {
                System.out.printf("%s", this.id);
                return contractDate.substring(contractDate.length() - 4);
            } catch (Exception e) {
                return "2020";
            }
        }
    }

}
