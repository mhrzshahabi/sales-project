package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.MaterialDTO;
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
public class ContractDTO {

    private String no;
    private Date date;
    private Date affectFrom;
    private Date affectUpTo;
    private String content;
    private String description;

    private Long parentId;
    private Long materialId;
    private Long contractTypeId;

    // contractContacts
    private Long buyerId;
    private Long sellerId;
    private Long agentBuyerId;
    private Long agentSellerId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractInfo")
    public static class Info extends ListGridInfo {
        private List<ContractDetailDTO.Info> contractDetails;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractListGridInfo")
    public static class ListGridInfo extends ContractDTO {
        private Long id;
        private MaterialDTO.Info material;
        private List<ContractContactDTO.Info> contractContacts;

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
    @ApiModel("ContractCreateRq")
    public static class Create extends ContractDTO {
        private List<ContractDetailDTO.Info> contractDetails;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractUpdateRq")
    public static class Update extends ContractDTO {
        private List<ContractDetailDTO.Info> contractDetails;

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDeleteRq")
    public static class Delete {
        private List<ContractDetailDTO.Info> contractDetails;

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
