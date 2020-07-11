package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDetailTypeParamDTO {

    private String name;
    private String key;
    private DataType type;
    private String reference;
    private String defaultValue;
    private Boolean required;

    @Transient
    private Integer width = 100;

    private Long unitId;
    private Long contractDetailTypeId;

    private List<ContractDetailTypeParamValueDTO.Create> contractDetailTypeParamValues;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeParamInfo")
    public static class Info extends ContractDetailTypeParamDTO {

        private Long id;

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
    @ApiModel("ContractDetailTypeParamCreateRq")
    public static class Create extends ContractDetailTypeParamDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeParamUpdateRq")
    public static class Update extends ContractDetailTypeParamDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeParamDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
