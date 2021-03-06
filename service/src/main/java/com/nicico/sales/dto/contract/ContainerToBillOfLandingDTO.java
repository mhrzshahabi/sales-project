package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.contract.BillOfLanding;
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
public class ContainerToBillOfLandingDTO {
    private Long billOfLandingId;

    private String containerType;

    private String containerNo;

    private String sealNo;

    private Long quantity;

    private String quantityType;

    private Long weight;

    private Long unitId;



    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContainerToBillOfLandingInfo")
    public static class Info extends ContainerToBillOfLandingDTO {

        private Long id;
//        private BillOfLandingDTO.Info billOfLanding;
        private UnitDTO.Info unit;

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
    @ApiModel("ContainerToBillOfLandingCreateRq")
    public static class Create extends ContainerToBillOfLandingDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContainerToBillOfLandingUpdateRq")
    public static class Update extends ContainerToBillOfLandingDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContainerToBillOfLandingDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
