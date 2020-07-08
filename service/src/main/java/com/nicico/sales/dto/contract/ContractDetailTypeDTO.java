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
public class ContractDetailTypeDTO {

    private String code;
    private Long materialId;
    private String titleFa;
    private String titleEn;

    private List<ContractDetailTypeParamDTO.Create> contractDetailTypeParams;
    private List<ContractDetailTypeTemplateDTO.Create> contractDetailTypeTemplates;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeInfo")
    public static class Info extends ContractDetailTypeDTO {

        private Long id;

        private MaterialDTO.Info material;

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
    @ApiModel("ContractDetailTypeCreateRq")
    public static class Create extends ContractDetailTypeDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeUpdateRq")
    public static class Update extends ContractDetailTypeDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
