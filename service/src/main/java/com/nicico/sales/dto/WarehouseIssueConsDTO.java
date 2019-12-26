package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
public class WarehouseIssueConsDTO {

    private Long shipmentId;
    private Double amountSarcheshmeh;
    private Double amountMiduk;
    private Double amountSungon;
    private Double totalAmount;
    private Double amountDraft;
    private Double amountPms;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseIssueConsInfo")
    public static class Info extends WarehouseIssueConsDTO {
        private Long id;
        private ShipmentDTO Shipment;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseIssueConsCreateRq")
    public static class Create extends WarehouseIssueConsDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseIssueConsUpdateRq")
    public static class Update extends WarehouseIssueConsDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("WarehouseIssueConsDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("WarehouseIssueConsSpecRs")
    public static class WarehouseIssueConsSpecRs {
        private SpecRs response;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<WarehouseIssueConsDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
