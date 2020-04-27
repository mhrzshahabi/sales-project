package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.MaterialDTO;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.EnumSet;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class IncotermStepsDTO {

    private Long incotermId;
    private Long incotermStepId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermStepsInfo")
    public static class Info extends IncotermStepsDTO {

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
    @ApiModel("IncotermStepsCreateRq")
    public static class Create extends IncotermStepsDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermStepsUpdateRq")
    public static class Update extends IncotermStepsDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermStepsDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
