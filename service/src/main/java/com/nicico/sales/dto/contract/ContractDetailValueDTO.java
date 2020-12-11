package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.CDTPDynamicTableValueDTO;
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
public class ContractDetailValueDTO {

    private String name;
    private String key;
    private DataType type;
    private String reference;
    private String value;
    private String referenceJsonValue;
    private Boolean required;

    private Long unitId;
    private Long contractDetailId;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailValueInfo")
    public static class Info extends ContractDetailValueDTO {

        private Long id;
        private List<CDTPDynamicTableValueDTO.Info> dynamicTableValues;

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
    @ApiModel("ContractDetailValueCreateRq")
    public static class Create extends ContractDetailValueDTO {

        private List<CDTPDynamicTableValueDTO.Create> dynamicTableValues;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailValueUpdateRq")
    public static class Update extends ContractDetailValueDTO {

        private List<CDTPDynamicTableValueDTO.Update> dynamicTableValues;

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailValueDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
