package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RemittanceViewDTO {
    private Long id;
    private Long remittanceId;
    private Long amount;
    private Long fDepotId;
    private String cDescription;
    private Long destinationTozineId;
    private Long inventoryId;
    private String railPolompNo;
    private String securityPolompNo;
    private Long sourceTozineId;
    private Long unitId;
    private Long weight;
    private String inventoryLabel;
    private Boolean remainedBandar;
    private Long nowTarget;
    private Long firstTarget;
    private Long nowRd;
    private Long nowR;
    private Long firstRd;
    private Long firstR;
    private String tozinTableId;
    private String cardId;
    private Long gdscode;
    private String contenerNo3;
    private String ctrlDescOut;
    private String dat;
    private String drvname;
    private String havcode;
    private String isInView;
    private String plak;
    private Long sourceid;
    private Long targetid;
    private String tozineId;
    private Long wazn;
    private Boolean bIsRail;
    private String remittanceCode;
    private String remittanceDescription;
    private Long shipmentId;
    private Long packingContainerId;
    private String automationLetterNo;
    private String automationLetterNoList;
    private String automationLetterDate;
    private Boolean hasSeparated;
    private Long remittanceWeight;




    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceViewInfo")
    public static class Info extends RemittanceViewDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceViwCreateRq")
    public static class Create extends RemittanceViewDTO {

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceViwUpdateRq")
    public static class Update extends RemittanceViewDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RemittanceViwDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
