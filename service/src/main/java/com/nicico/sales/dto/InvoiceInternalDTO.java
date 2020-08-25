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
public class InvoiceInternalDTO {

    private String id;
    private String lcId;
    private String havalehId;
    private String invDate;
    private String buyerId;
    private String customerId;
    private Long goodId;
    private Double invOtherKosorat;
    private String havFinalDate;
    private Double weightReal;
    private Double ghematUnit;
    private Double totalKosorat;
    private Double mablaghKol;
    private String shomarehSoratHesab;
    private Double payForAvarezMalyat;
    private Double payForAvarezAlayandegi;
    private String invSented;
    private Long typeForosh;
    private Long haveAlayandegi;
    private String codeNosaAlayandegi;
    private String markazHazineAlayandegi;
    private Long haveMalyat;
    private String codeNosaMalyat;
    private String markazHazineMalyat;
    private String codeNosaBank;
    private String codeNosaCustomer;
    private String codeEtebarNosaCustomer;
    private String codeMarkazHazineCustomer;
    private String codeMarkazHazineHlc;
    private String codeNosaMahsol;
    private String codeMarkazHazineMahsol;
    private String bankGroupDesc;
    private String customerName;
    private String gdsName;
    private String groupGoodsNosa;
    private String groupGoodName;
    private String lcDateSarReceid;
    private String codeTafsiliNosa;

    @Getter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalInfo")
    public static class Info extends InvoiceInternalDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalCreateRq")
    public static class Create extends InvoiceInternalDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalUpdateRq")
    public static class Update extends InvoiceInternalDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private String id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("InvoiceInternalDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<String> ids;
    }

}
