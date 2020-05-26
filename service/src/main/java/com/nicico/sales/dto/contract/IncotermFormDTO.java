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
public class IncotermFormDTO {

    private String code;
    private String title;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermFormInfo")
    public static class Info extends IncotermFormDTO {

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
    @ApiModel("IncotermFormCreateRq")
    public static class Create extends IncotermFormDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermFormUpdateRq")
    public static class Update extends IncotermFormDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermFormDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
