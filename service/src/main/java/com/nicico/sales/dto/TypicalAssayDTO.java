package com.nicico.sales.dto;


import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TypicalAssayDTO {

    private BigDecimal minValue;
    private BigDecimal maxValue;
    private Long unitId;
    private Long itemElementId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TypicalAssayInfo")
    public static class Info extends TypicalAssayDTO {
        private Long id ;
        private Date createDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TypicalAssayCreateRq")
    public static class Create extends TypicalAssayDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TypicalAssayUpdateRq")
    public static class Update extends TypicalAssayDTO {
        @NonNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TypicalAssayDeleteRq")
    public static class Delete{
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
