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
public class VesselDTO {

    private String name;
    private String type;
    private String imo;
    private Long yearOfBuild;
    private Double length;
    private Double beam;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("VesselInfo")
    public static class Info extends VesselDTO {
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
    @ApiModel("VesselCreateRq")
    public static class Create extends VesselDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("VesselUpdateRq")
    public static class Update extends VesselDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("VesselDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
