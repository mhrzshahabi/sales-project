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
public class ContractDTO2 {

    private String no;
    private Date date;
    private Date affectFrom;
    private Date affectUpTo;
    private String content;
    private String description;

    private Long parentId;
    private Long materialId;
    private Long contractTypeId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractInfo")
    public static class Info extends ContractDTO2 {

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
    @ApiModel("ContractCreateRq")
    public static class Create extends ContractDTO2 {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractUpdateRq")
    public static class Update extends ContractDTO2 {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
