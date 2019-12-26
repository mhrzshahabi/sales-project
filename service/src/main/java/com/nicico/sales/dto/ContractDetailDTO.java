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
public class ContractDetailDTO {

    private Long id;
    private Long contract_id;
    private String name_ContactAgentSeller;
    private String phone_ContactAgentSeller;
    private String mobile_ContactAgentSeller;
    private String address_ContactAgentSeller;
    private String name_ContactSeller;
    private String phone_ContactSeller;
    private String mobile_ContactSeller;
    private String address_ContactSeller;
    private String name_ContactAgentBuyer;
    private String phone_ContactAgentBuyer;
    private String mobile_ContactAgentBuyer;
    private String address_ContactAgentBuyer;
    private String name_ContactBuyer;
    private String phone_ContactBuyer;
    private String mobile_ContactBuyer;
    private String address_ContactBuyer;
    private String feild_all_defintitons_save;
    ///
    private String article2_13_1;
    private String responsibleTelerons;
    private String article3_number17;
    private String article3_number17_7;
    private String article3_number17_8;
    private String article3_number17_9;
    private String article3_number17_10;
    private String article3_number17_11;
    private String article3_number17_12;
    private String article3_number17_2;
    private String article3_number17_3;
    private String article3_number17_4;
    private String article3_number17_5;
    private String article3_number17_6;
    private String article4_number18;
    private String amount_number19_1;
    private String amount_number19_2;
    private String shipment_number20;
    private String article5_number21_6;
    private String article5_Note1_lable;
    private String article5_Note1_value;
    private String article6_number31;
    private String article6_number31_1;
    private String article6_number32_1;
    private String article6_number34;
    private String article6_Containerized;
    private String article6_Containerized_number36_1;
    private String article6_Containerized_number33;
    private String article6_Containerized_number37_1;
    private String article6_Containerized_number37_2;
    private String article6_Containerized_number33_1;
    private String article6_Containerized_number37_3;
    private String article6_Containerized_number32;
    private String article6_Containerized_4;
    private String article6_Containerized_5;
    private String article7_number41;
    private String article7_number3;
    private String article7_number37;
    private String article7_number3_1;
    private String article7_number40_2;
    private String article7_number40_3;
    private String article8_number42;
    private String article8_3;
    private String article8_value;
    private String article8_number43;
    private String article8_number44_1;
    private String article9_number45;
    private String article9_number22;
    private String article9_Englishi_number22;
    private String article9_number23;
    private String article9_number48;
    private String article9_number49_1;
    private String article9_number51;
    private String article9_number54;
    private String article9_number54_1;
    private String article9_number55;
    private String article9_ImportantNote;
    private String article10_number56;
    private String article10_number57;
    private String article10_number58;
    private String article10_number59;
    private String article10_number60;
    private Double article10_number61;
    private String string_Currency;
    private String Prefixmolybdenum;
    private String PrefixCopper;
    private String PrefixC;
    private String PrefixS;
    private String PrefixPb;
    private String PrefixP;
    private String PrefixSi;
    private Integer typical_c;
    private Integer typical_s;
    private Integer typical_pb;
    private Integer typical_p;
    private Integer typical_Si;
    private Integer typical_size_min;
    private Integer toleranceMO;
    private Integer toleranceCU;
    private Integer toleranceC;
    private Integer toleranceS;
    private Integer tolerancePb;
    private Integer toleranceP;
    private Integer toleranceSi;
    private String typical_unitMO;
    private String typical_unitCU;
    private String typical_unitC;
    private String typical_unitS;
    private String typical_unitPb;
    private String typical_unitP;
    private String typical_unitSi;
    ////
    private Integer discountValueOne;
    private Integer discountValueOne_1;
    private Integer discountValueOne_2;
    private Integer discountValueTwo;
    private Integer discountValueTwo_1;
    private Integer discountValueTwo_2;
    private Integer discountValueThree;
    private Integer discountValueThree_1;
    private Integer discountValueThree_2;
    private Integer discountValueFour;
    private Integer discountValueFour_1;
    private Integer discountValueFour_2;
    private Integer discountValueFive;
    private Integer discountValueFive_1;
    private Integer discountValueFive_2;
    private Integer discountValueSix;
    private Integer discountValueSix_1;
    private Integer discountValueSix_2;
    private Integer discountValueSeven;
    private Integer discountValueSeven_1;
    private Integer discountValueSeven_2;
    private Integer discountValueEight;
    private Integer discountValueEight_1;
    private Integer discountValueEight_2;
    private Integer discountValueNine;
    private Integer discountValueNine_1;
    private Integer discountValueNine_2;
    private Integer discountValueTen;
    private Integer discountValueTen_1;
    private Integer discountValueTen_2;
    private Integer discountValueEleven;
    private Integer discountValueEleven_1;
    private Integer discountValueEleven_2;

    private String discountFor;
    private String discountPerfixOne;
    private String discountUnitOne;
    private String discountPerfixOne_1;
    private String discountPerfixTwo;
    private String discountUnitTwo;
    private String discountPerfixTwo_1;
    private String discountPerfixThree;
    private String discountPerfixThree_1;
    private String discountUnitFour;
    private String discountPerfixFour_1;
    private String discountPerfixFive;
    private String discountUnitFive;
    private String discountPerfixFive_1;
    private String discountPerfixSix;
    private String discountUnitSix;
    private String discountPerfixSix_1;
    private String discountPerfixSeven;
    private String discountUnitSeven;
    private String discountPerfixSeven_1;
    private String discountPerfixEight;
    private String discountUnitEight;
    private String discountPerfixEight_1;
    private String discountPerfixNine;
    private String discountUnitNine;
    private String discountPerfixNine_1;
    private String discountPerfixTen;
    private String discountUnitTen;
    private String discountPerfixTen_1;
    private String discountPerfixEleven;
    private String discountUnitEleven;
    private String discountPerfixEleven_1;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailInfo")
    public static class Info extends ContractDetailDTO {
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
    @ApiModel("ContractDetailCreateRq")
    public static class Create extends ContractDetailDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailUpdateRq")
    public static class Update extends ContractDetailDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ApiModel("ContractDetailSpecRs")
    public static class ContractDetailSpecRs {
        private SpecRs response;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SpecRs {
        private List<ContractDetailDTO.Info> data;
        private Integer status;
        private Integer startRow;
        private Integer endRow;
        private Integer totalRows;
    }
}
