package com.nicico.sales.dto;

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
public class MaterialElementDTO {

    private Long materialId;
    private Long elementId;
    private Long unitId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialElementInfo")
    public static class Info extends MaterialElementDTO {

        private Long id;
        private MaterialDTO.Info material;
        private ElementDTO.Info element;
        private UnitDTO.Info unit;
        private String elementName;
        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;

        public String getElementName() {
            return this.element.getName();
        }
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialElementCreateRq")
    public static class Create extends MaterialElementDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialElementUpdateRq")
    public static class Update extends MaterialElementDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("MaterialElementDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
