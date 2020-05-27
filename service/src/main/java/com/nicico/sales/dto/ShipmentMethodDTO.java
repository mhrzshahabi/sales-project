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
public class ShipmentMethodDTO {
    private String shipmentMethod;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("VesselInfo")
    public static class Info extends ShipmentMethodDTO {
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
    @ApiModel("ShipmentMethodRq")
    public static class Create extends ShipmentMethodDTO {}

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentMethodRq")
    public static class Update extends ShipmentMethodDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ShipmentMethodRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
