package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
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
public class ContractDetailDTO {

    private String content;
    private Long contractId;
    private Long contractDetailTypeId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailInfo")
    public static class Info extends ContractDetailDTO {

        private Long id;

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
    @ApiModel("ContractDetailCreateRq")
    public static class Create extends ContractDetailDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailUpdateRq")
    public static class Update extends ContractDetailDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}