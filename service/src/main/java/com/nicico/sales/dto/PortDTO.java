package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@ToString
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PortDTO {

    private String port;
    private Long countryId;
    private String loa;
    private String beam;
    private String arrival;

    @Getter
    @Setter
    @ApiModel("PortInfoTuple")
    @ToString
    public static class PortInfoTuple {
        private String port;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PortInfo")
    public static class Info extends PortDTO {
        private Long id;
        private CountryDTO.Info country;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PortCreateRq")
    public static class Create extends PortDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PortUpdateRq")
    public static class Update extends PortDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PortDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
