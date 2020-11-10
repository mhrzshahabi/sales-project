package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.contract.BillOfLandingDTO;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.entities.contract.BillOfLanding;
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
public class PackingListDTO {

    private Long id;
    private Long billOfLandingId;
    private Long shipmentId;
    private String bookingNo;
    private String description;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PackingListDTOInfo")
    public static class Info extends PackingListDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private String description;
        private String name;
        private Integer version;
        private ShipmentDTO.Info shipment;
        private BillOfLandingDTO.Info billOfLanding;

    }
    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PackingListDTOCreateRq")
    public static class Create extends PackingListDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PackingListDTOUpdateRq")
    public static class Update extends PackingListDTO {
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
