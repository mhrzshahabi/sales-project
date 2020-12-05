package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
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
public class CDTPDynamicTableDTO {

    private Long colNum;
    private String headerType = "String";
    private String headerValue;
    private String headerKey;
    private Long cdtpId;

    private String valueType = "String";
    private String displayField;
    private Boolean required;
    private String regexValidator;
    private String defaultValue;
    private Integer maxRows = 0;
    private String description;
    private String initialCriteria;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableInfo")
    public static class InfoWithoutCDTP extends CDTPDynamicTableDTO {

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
    @ApiModel("CDTPDynamicTableInfo")
    public static class Info extends InfoWithoutCDTP {
        private ContractDetailTypeParamDTO.Info cdtp;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableCreateRq")
    public static class Create extends CDTPDynamicTableDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableUpdateRq")
    public static class Update extends CDTPDynamicTableDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CDTPDynamicTableDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
