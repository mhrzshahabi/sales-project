package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.RemittanceDTO;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.dto.ShipmentMethodDTO;
import com.nicico.sales.dto.ShipmentTypeDTO;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.entities.base.ShipmentMethod;
import com.nicico.sales.model.entities.base.ShipmentType;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import com.nicico.sales.model.entities.warehouse.Remittance;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
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
public class RemittanceToBillOfLandingDTO {
    private Long billOfLandingId;

    private Long remittanceId;

    private Integer netWeight;

    private Integer grossWeight;

    private Integer bundlesNum;

    private BigDecimal moisture;



    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceToBillOfLandingInfo")
    public static class Info extends RemittanceToBillOfLandingDTO {

        private Long id;
//        private BillOfLandingDTO.Info billOfLanding;
        private RemittanceDTO.InfoWithInspections remittance;

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
    @ApiModel("RemittanceToBillOfLandingCreateRq")
    public static class Create extends RemittanceToBillOfLandingDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceToBillOfLandingUpdateRq")
    public static class Update extends RemittanceToBillOfLandingDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceToBillOfLandingDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
