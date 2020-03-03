package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.ContractShipmentAudit;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractShipmentAuditDTO {

    private ContractShipmentAudit.ContractShipmentAuditId id;
    private Long revType;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date lastModifiedDate;
    private String createdBy;
    private String lastModifiedBy;
    private Long contractId;
    private String plan;
    private Long shipmentRow;
    private Long dischargeId;
    private String address;
    private Double amount;
    private String sendDate;
    private Long duration;
    private Long tolorance;

    @Getter
    @Accessors(chain = true)
    @ApiModel("ContractShipmentInfo")
    public static class Info extends ContractShipmentAuditDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<ContractShipmentAuditDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
