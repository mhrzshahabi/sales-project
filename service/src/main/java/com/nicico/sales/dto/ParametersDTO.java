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
public class ParametersDTO {

    private String paramName;
    private String paramValue;
    private Integer materialId;
    private Integer categoryValue;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ParametersInfo")
    public static class Info extends ParametersDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ParametersCreateRq")
    public static class Create extends ParametersDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ParametersUpdateRq")
    public static class Update extends ParametersDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ParametersDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
