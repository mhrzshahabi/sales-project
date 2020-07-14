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
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractAuditDTO2 {

    private Long revType;
    private String no;
    private Date date;
    private Date affectFrom;
    private Date affectUpTo;
    private String content;
    private String description;
    private Long contractTypeId;
    private Long materialId;
    private Long parentId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractAuditInfo")
    public static class Info extends ContractAuditDTO2 {

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
    @ApiModel("ContractAuditCreateRq")
    public static class Create extends ContractAuditDTO2 {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractAuditUpdateRq")
    public static class Update extends ContractAuditDTO2 {

        @NotNull
        @ApiModelProperty(required = true)
        private AuditId auditId;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractAuditDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<AuditId> auditIds;
    }
}
