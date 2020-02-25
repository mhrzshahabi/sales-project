package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
public class ContractPersonDTO {

    private Long contractId;
    private Long personId;
    private String status;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractPersonInfo")
    public static class Info extends ContractPersonDTO {
        private Long id;
        private ContractDTO contract;
        private PersonDTO person;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractPersonCreateRq")
    public static class Create extends ContractPersonDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractPersonUpdateRq")
    public static class Update extends ContractPersonDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractPersonDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
