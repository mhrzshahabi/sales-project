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
public class IncotermAspectDTO {

    private String code;
    private String titleFa;
    private String titleEn;
    private String description;
    private Boolean requiredParty;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermAspectInfo")
    public static class Info extends IncotermAspectDTO {

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
    @ApiModel("IncotermAspectCreateRq")
    public static class Create extends IncotermAspectDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermAspectUpdateRq")
    public static class Update extends IncotermAspectDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermAspectDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
