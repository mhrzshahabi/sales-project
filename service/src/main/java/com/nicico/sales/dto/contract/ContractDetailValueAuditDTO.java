package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.enumeration.DataType;
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
public class ContractDetailValueAuditDTO {

    private Long revType;
    private String name;
    private String key;
    private DataType type;
    private String value;
    private Long contractDetailId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailValueAuditInfo")
    public static class Info extends ContractDetailValueAuditDTO {

        private AuditId auditId;

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
    @ApiModel("ContractDetailValueAuditCreateRq")
    public static class Create extends ContractDetailValueAuditDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailValueAuditUpdateRq")
    public static class Update extends ContractDetailValueAuditDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private AuditId auditId;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailValueAuditDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<AuditId> auditIds;
    }
}
