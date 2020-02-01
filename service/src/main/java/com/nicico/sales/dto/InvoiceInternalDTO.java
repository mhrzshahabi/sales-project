package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

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
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<InvoiceInternalDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
