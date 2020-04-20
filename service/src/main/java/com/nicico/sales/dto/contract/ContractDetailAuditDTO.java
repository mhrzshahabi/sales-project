package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.EnumSet;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDetailAuditDTO {

    private Long revType;
    private String content;
    private Long contractId;
    private Long contractDetailTypeId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailAuditInfo")
    public static class Info extends ContractDetailAuditDTO {

        private AuditId auditId;

        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private EnumSet<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailAuditCreateRq")
    public static class Create extends ContractDetailAuditDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailAuditUpdateRq")
    public static class Update extends ContractDetailAuditDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private AuditId auditId;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailAuditDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<AuditId> auditIds;
    }
}