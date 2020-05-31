package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.ContractAudit;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractAuditDTO {

    private ContractAudit.ContractAuditId id;
    private Long revType;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date lastModifiedDate;
    private String createdBy;
    private String lastModifiedBy;
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
    @NotNull
    @ApiModelProperty(required = true)
    private Long contactId; // contactByBuyerId
    private Long contactByBuyerAgentId;
    private Long contactBySellerId;
    private Long contactBySellerAgentId;


    @Getter
    @Accessors(chain = true)
    @ApiModel("ContractAuditInfo")
    public static class Info extends ContractAuditDTO {
    }
}
