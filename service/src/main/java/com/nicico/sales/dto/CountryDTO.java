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
public class CountryDTO {

    private String nameFa;
    private String nameEn;

    @Getter
    @Setter
    @ApiModel("CountryInfoTuple")
    public static class CountryInfoTuple {
        private String nameFa;
        private String nameEn;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CountryInfo")
    public static class Info extends CountryDTO {
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
    @ApiModel("CountryCreateRq")
    public static class Create extends CountryDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CountryUpdateRq")
    public static class Update extends CountryDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        @NotNull
        @ApiModelProperty(required = true)
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("CountryDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("CountrySpecRs")
    public static class CountrySpecRs {
        private SpecRs response;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<CountryDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
