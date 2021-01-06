package com.nicico.sales.dto.invoice.foreign;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.contract.BillOfLandingDTO;
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
public class ForeignInvoiceBillOfLandingDTO {

    private Long billOfLandingId;
    private Long foreignInvoiceId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceBillOfLandingInfo")
    public static class Info extends ForeignInvoiceBillOfLandingDTO {

        private Long id;
        private BillOfLandingDTO.Info billOfLanding;

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
    @ApiModel("ForeignInvoiceBillOfLandingCreateRq")
    public static class Create extends ForeignInvoiceBillOfLandingDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceBillOfLandingUpdateRq")
    public static class Update extends ForeignInvoiceBillOfLandingDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ForeignInvoiceBillOfLandingDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
