package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.contract.ContractDTO;
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
public class ContractShipmentDTO {

    private Long loadPortId;
    private Double quantity;
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date sendDate;
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date automationDate;
    private Long tolorance;
    private Long contractId;
    private Long parentId;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractShipmentInfo")
    public static class Info extends ContractShipmentDTO {
        private Long id;
        private ContractDTO contract;
        private PortDTO loadPort;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractShipmentInfo")
    public static class ContractShipmentFIInfo extends ContractShipmentDTO {

        private Long id;
        private ContractDTO.ListGridInfo contract;
        private PortDTO loadPort;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractShipmentTuple")
    public static class Tuple extends ContractShipmentDTO {
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
    @ApiModel("ContractShipmentCreateRq")
    public static class Create extends ContractShipmentDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractShipmentUpdateRq")
    public static class Update extends ContractShipmentDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractShipmentDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
