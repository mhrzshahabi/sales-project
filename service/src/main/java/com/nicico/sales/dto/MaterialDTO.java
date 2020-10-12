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
public class MaterialDTO {

    private String descEN;
    private String descFA;
    private String desc;
    private String code;
    private Long unitId;
    private String abbreviation;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialInfo")
    public static class Info extends MaterialDTO {
        private Long id;
        private UnitDTO unit;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialTuple")
    public static class MaterialTuple {
        private Long id;
        private String descEN;
        private String descFA;
        private String code;
        private Long unitId;
        private UnitDTO unit;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialCreateRq")
    public static class Create extends MaterialDTO {
        @ApiModelProperty(required = true)
        private Long unitId;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialUpdateRq")
    public static class Update extends MaterialDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        @ApiModelProperty(required = true)
        private Long unitId;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
