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
public class BankDTO {

    private String name;
    private String nameFA;
    private String nameEN;
    private Long countryId;
    private String address;
    private String coreBranch;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BankInfo")
    public static class Info extends BankDTO {
        private Long id;
        private CountryDTO country;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BankCreateRq")
    public static class Create extends BankDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BankUpdateRq")
    public static class Update extends BankDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BankDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
