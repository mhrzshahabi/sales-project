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
public class RemittanceDetailDTO {

    private Long amount;
    private Long unitId;
    private Long remittanceId;
    private Long depotId;
    private String railPolompNo;
    private String securityPolompNo;
    private Long weight;


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailInfo")
    public static class Info extends RemittanceDetailDTO {

        private Long id;
        private UnitDTO.Info unit;
//        private Remittance remittance;


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
    @ApiModel("RemittanceDetailCreateRq")
    public static class Create extends RemittanceDetailDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailUpdateRq")
    public static class Update extends RemittanceDetailDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceDetailDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    public static class WithInventory extends RemittanceDetailDTO {
        InventoryDTO.Create inventory;
        TozinTableDTO.Create sourceTozin;
        TozinTableDTO.Create destinationTozin;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    public static class WithRemittanceAndInventory {
        private RemittanceDTO.Create remittance;
        private List<RemittanceDetailDTO.WithInventory> remittanceDetails;
    }
}
