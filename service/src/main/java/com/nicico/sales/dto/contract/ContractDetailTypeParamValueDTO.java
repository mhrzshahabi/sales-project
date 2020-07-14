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
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDetailTypeParamValueDTO {

    private String value;
    private Long contractDetailTypeParamId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeParamValueInfo")
    public static class Info extends ContractDetailTypeParamValueDTO {

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
    @ApiModel("ContractDetailTypeParamValueCreateRq")
    public static class Create extends ContractDetailTypeParamValueDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeParamValueUpdateRq")
    public static class Update extends ContractDetailTypeParamValueDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailTypeParamValueDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
