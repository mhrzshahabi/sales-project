package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
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
public class InventoryDTO {

    private Long materialItemId;
    private String label;


    @Getter
    @Setter
    @Accessors(chain = true)
    public static class Info extends InventoryDTO {
        private Long id;
        private MaterialItemDTO.Info materialItem;
        private List<RemittanceDetailDTO.Info> remittanceDetails;
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
    public static class Create extends InventoryDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    public static class Update extends InventoryDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
