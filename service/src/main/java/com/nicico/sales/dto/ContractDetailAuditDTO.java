package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.ContractDetailAudit;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Date;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDetailAuditDTO {

    private ContractDetailAudit.ContractDetailAuditId id;
    private Long revType;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date lastModifiedDate;
    private String createdBy;
    private String lastModifiedBy;
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
    private Double typical_c;
    private Double typical_s;
    private Double typical_pb;
    private Double typical_p;
    private Double typical_Si;
    private Double typical_size_min;
    private Double toleranceMO;
    private Double toleranceCU;
    private Double toleranceC;
    private Double toleranceS;
    private Double tolerancePb;
    private Double toleranceP;
    private Double toleranceSi;
    private String typical_unitMO;
    private String typical_unitCU;
    private String typical_unitC;
    private String typical_unitS;
    private String typical_unitPb;
    private String typical_unitP;
    private String typical_unitSi;
    ////
    private Double discountValueOne;
    private Double discountValueOne_1;
    private Double discountValueOne_2;
    private Double discountValueTwo;
    private Double discountValueTwo_1;
    private Double discountValueTwo_2;
    private Double discountValueThree;
    private Double discountValueThree_1;
    private Double discountValueThree_2;
    private Double discountValueFour;
    private Double discountValueFour_1;
    private Double discountValueFour_2;
    private Double discountValueFive;
    private Double discountValueFive_1;
    private Double discountValueFive_2;
    private Double discountValueSix;
    private Double discountValueSix_1;
    private Double discountValueSix_2;
    private Double discountValueSeven;
    private Double discountValueSeven_1;
    private Double discountValueSeven_2;
    private Double discountValueEight;
    private Double discountValueEight_1;
    private Double discountValueEight_2;
    private Double discountValueNine;
    private Double discountValueNine_1;
    private Double discountValueNine_2;
    private Double discountValueTen;
    private Double discountValueTen_1;
    private Double discountValueTen_2;
    private Double discountValueEleven;
    private Double discountValueEleven_1;
    private Double discountValueEleven_2;

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
    @Accessors(chain = true)
    @ApiModel("ContractDetailInfo")
    public static class Info extends ContractDetailAuditDTO {
    }
}