package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.contract.BillOfLandingDTO;
import com.nicico.sales.model.entities.warehouse.PackingList;
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
public class PackingContainerDTO {

    private Long id;
    private Long packingListId;
    private String containerNo;
    private String sealNo;

    private Long ladingDate;
    private Long packageCount;
    private Long subpackageCount;
    private Long strapWeight;

    private Long palletCount;
    private Long palletWeight;
    private Long woodWeight;
    private Long barrelWeight;
    private Long containerWeight;
    private Long contentWeight;
    private Long vgmWeight;
    private Long netWeight;
    private String description;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PackingListDTOInfo")
    public static class Info extends PackingContainerDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private String description;
        private String name;
        private Integer version;
        private PackingListDTO.Info packingList;

    }
    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PackingListDTOCreateRq")
    public static class Create extends PackingContainerDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PackingListDTOUpdateRq")
    public static class Update extends PackingContainerDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PackingListDTOeDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
