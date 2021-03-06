package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.SymbolUnit;
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
public class UnitDTO {

    private String nameFA;
    private String nameEN;
    private String name;
    private CategoryUnit categoryUnit;
    private SymbolUnit symbolUnit;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("UnitInfo")
    public static class Info extends UnitDTO {

        private Long id;
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
    @ApiModel("UnitTuple")
    public static class Tuple extends UnitDTO {
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
    @ApiModel("UnitCreateRq")
    public static class Create extends UnitDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("UnitUpdateRq")
    public static class Update extends UnitDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("UnitDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
