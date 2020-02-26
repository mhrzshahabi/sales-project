package com.nicico.sales.model.entities.base;

import lombok.*;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect(
        "SELECT" +
                " *" +
                " FROM" +
                " TBL_CONTRACT_DETAIL_AUD"
)
public class ContractDetailAudit {

    @EmbeddedId
    private ContractDetailAuditId id;
    @Column(name = "REVTYPE")
    private Long revType;
    @Column(name = "d_created_date", nullable = false, updatable = false)
    private Date createdDate;
    @Column(name = "c_created_by", nullable = false, updatable = false)
    private String createdBy;
    @Column(name = "d_last_modified_date")
    private Date lastModifiedDate;
    @Column(name = "c_last_modified_by")
    private String lastModifiedBy;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contractDetail2contract"))
    private Contract contract;
    @Column(name = "CONTRACT_ID")
    private Long contract_id;
    @Column(name = "NAME_CONTACTAGENTSELLER", length = 4000)
    private String name_ContactAgentSeller;
    @Column(name = "PHONE_CONTACTAGENTSELLER", length = 4000)
    private String phone_ContactAgentSeller;
    @Column(name = "MOBILE_CONTACTAGENTSELLER", length = 4000)
    private String mobile_ContactAgentSeller;
    @Column(name = "ADDRESS_CONTACTAGENTSELLER", length = 4000)
    private String address_ContactAgentSeller;
    @Column(name = "NAME_CONTACTSELLER", length = 4000)
    private String name_ContactSeller;
    @Column(name = "PHONE_CONTACTSELLER", length = 4000)
    private String phone_ContactSeller;
    @Column(name = "MOBILE_CONTACTSELLER", length = 4000)
    private String mobile_ContactSeller;
    @Column(name = "ADDRESS_CONTACTSELLER", length = 4000)
    private String address_ContactSeller;
    @Column(name = "NAME_CONTACTAGENTBUYER", length = 4000)
    private String name_ContactAgentBuyer;
    @Column(name = "PHONE_CONTACTAGENTBUYER", length = 4000)
    private String phone_ContactAgentBuyer;
    @Column(name = "MOBILE_CONTACTAGENTBUYER", length = 4000)
    private String mobile_ContactAgentBuyer;
    @Column(name = "ADDRESS_CONTACTAGENTBUYER", length = 4000)
    private String address_ContactAgentBuyer;
    @Column(name = "NAME_CONTACTBUYER", length = 4000)
    private String name_ContactBuyer;
    @Column(name = "PHONE_CONTACTBUYER", length = 4000)
    private String phone_ContactBuyer;
    @Column(name = "MOBILE_CONTACTBUYER", length = 4000)
    private String mobile_ContactBuyer;
    @Column(name = "ADDRESS_CONTACTBUYER", length = 4000)
    private String address_ContactBuyer;
    @Column(name = "FEILD_ALL_DEFINITIONS_SAVE", length = 4000)
    private String feild_all_defintitons_save;
    @Column(name = "ARTICLE2_13_1", length = 4000)
    private String article2_13_1;
    @Column(name = "RESPONSIBLETELERONS", length = 4000)
    private String responsibleTelerons;
    @Column(name = "ARTICLE3_NUMBER17", length = 4000)
    private String article3_number17;
    @Column(name = "ARTICLE3_NUMBER17_7", length = 4000)
    private String article3_number17_7;
    @Column(name = "ARTICLE3_NUMBER17_8", length = 4000)
    private String article3_number17_8;
    @Column(name = "ARTICLE3_NUMBER17_9", length = 4000)
    private String article3_number17_9;
    @Column(name = "ARTICLE3_NUMBER17_10", length = 4000)
    private String article3_number17_10;
    @Column(name = "ARTICLE3_NUMBER17_11", length = 4000)
    private String article3_number17_11;
    @Column(name = "ARTICLE3_NUMBER17_12", length = 4000)
    private String article3_number17_12;
    @Column(name = "ARTICLE3_NUMBER17_2", length = 4000)
    private String article3_number17_2;
    @Column(name = "ARTICLE3_NUMBER17_3", length = 4000)
    private String article3_number17_3;
    @Column(name = "ARTICLE3_NUMBER17_4", length = 4000)
    private String article3_number17_4;
    @Column(name = "ARTICLE3_NUMBER17_5", length = 4000)
    private String article3_number17_5;
    @Column(name = "ARTICLE3_NUMBER17_6", length = 4000)
    private String article3_number17_6;
    @Column(name = "ARTICLE4_NUMBER18", length = 4000)
    private String article4_number18;
    @Column(name = "AMOUNT_NUMBER19_1", length = 4000)
    private String amount_number19_1;
    @Column(name = "AMOUNT_NUMBER19_2", length = 4000)
    private String amount_number19_2;
    @Column(name = "SHIPMENT_NUMBER20", length = 4000)
    private String shipment_number20;
    @Column(name = "ARTICLE5_NUMBER21_6", length = 4000)
    private String article5_number21_6;
    @Column(name = "ARTICLE5_NOTE1_LABLE", length = 4000)
    private String article5_Note1_lable;
    @Column(name = "ARTICLE5_NOTE1_VALUE", length = 4000)
    private String article5_Note1_value;
    @Column(name = "ARTICLE6_NUMBER31", length = 4000)
    private String article6_number31;
    @Column(name = "ARTICLE6_NUMBER31_1", length = 4000)
    private String article6_number31_1;
    @Column(name = "ARTICLE6_NUMBER32_1", length = 4000)
    private String article6_number32_1;
    @Column(name = "ARTICLE6_NUMBER34", length = 4000)
    private String article6_number34;
    @Column(name = "ARTICLE6_CONTAINERIZED", length = 4000)
    private String article6_Containerized;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER36_1", length = 4000)
    private String article6_Containerized_number36_1;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER33", length = 4000)
    private String article6_Containerized_number33;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER37_1", length = 4000)
    private String article6_Containerized_number37_1;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER37_2", length = 4000)
    private String article6_Containerized_number37_2;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER33_1", length = 4000)
    private String article6_Containerized_number33_1;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER37_3", length = 4000)
    private String article6_Containerized_number37_3;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER32", length = 4000)
    private String article6_Containerized_number32;
    @Column(name = "ARTICLE6_CONTAINERIZED_4", length = 4000)
    private String article6_Containerized_4;
    @Column(name = "ARTICLE6_CONTAINERIZED_5", length = 4000)
    private String article6_Containerized_5;
    @Column(name = "ARTICLE7_NUMBER41", length = 4000)
    private String article7_number41;
    @Column(name = "ARTICLE7_NUMBER3", length = 4000)
    private String article7_number3;
    @Column(name = "ARTICLE7_NUMBER37", length = 4000)
    private String article7_number37;
    @Column(name = "ARTICLE7_NUMBER3_1", length = 4000)
    private String article7_number3_1;
    @Column(name = "ARTICLE7_NUMBER40_2", length = 4000)
    private String article7_number40_2;
    @Column(name = "ARTICLE7_NUMBER40_3", length = 4000)
    private String article7_number40_3;
    @Column(name = "ARTICLE8_NUMBER42", length = 4000)
    private String article8_number42;
    @Column(name = "ARTICLE8_3", length = 4000)
    private String article8_3;
    @Column(name = "ARTICLE8_VALUE", length = 4000)
    private String article8_value;
    @Column(name = "ARTICLE8_NUMBER43", length = 4000)
    private String article8_number43;
    @Column(name = "ARTICLE8_NUMBER44_1", length = 4000)
    private String article8_number44_1;
    @Column(name = "ARTICLE8_NUMBER45", length = 4000)
    private String article9_number45;
    @Column(name = "ARTICLE9_NUMBER22", length = 4000)
    private String article9_number22;
    @Column(name = "ARTICLE9_ENGLISHI_NUMBER22", length = 4000)
    private String article9_Englishi_number22;
    @Column(name = "ARTICLE9_NUMBER23", length = 4000)
    private String article9_number23;
    @Column(name = "ARTICLE9_NUMBER48", length = 4000)
    private String article9_number48;
    @Column(name = "ARTICLE9_NUMBER49_1", length = 4000)
    private String article9_number49_1;
    @Column(name = "ARTICLE9_NUMBER51", length = 4000)
    private String article9_number51;
    @Column(name = "ARTICLE9_NUMBER54", length = 4000)
    private String article9_number54;
    @Column(name = "ARTICLE9_NUMBER54_1", length = 4000)
    private String article9_number54_1;
    @Column(name = "ARTICLE9_NUMBER55", length = 4000)
    private String article9_number55;
    @Column(name = "ARTICLE9_IMPORTANTNOTE", length = 4000)
    private String article9_ImportantNote;
    @Column(name = "STRING_CURRENCY", length = 4000)
    private String string_Currency;
    @Column(name = "TYPICAL_C")
    private Long typical_c;
    @Column(name = "TYPICAL_S")
    private Long typical_s;
    @Column(name = "TYPICAL_PB")
    private Long typical_pb;
    @Column(name = "TYPICAL_P")
    private Long typical_p;
    @Column(name = "TYPICAL_SI")
    private Long typical_Si;
    @Column(name = "TYPICAL_SIZE_MIN", length = 4000)
    private String typical_size_min;
    @Column(name = "PREFIXMOLYBDENUM", length = 4000)
    private String PrefixMolybdenum;
    @Column(name = "PREFIXCOPPER", length = 4000)
    private String PrefixCopper;
    @Column(name = "PREFIXC", length = 4000)
    private String PrefixC;
    @Column(name = "PREFIXS", length = 4000)
    private String PrefixS;
    @Column(name = "PREFIXPB", length = 4000)
    private String PrefixPb;
    @Column(name = "PREFIXP", length = 4000)
    private String PrefixP;
    @Column(name = "PREFIXSI", length = 4000)
    private String PrefixSi;
    @Column(name = "TOLERANCEMO")
    private Double toleranceMO;
    @Column(name = "TOLERANCECU")
    private Double toleranceCU;
    @Column(name = "TOLERANCEC")
    private Double toleranceC;
    @Column(name = "TOLERANCES")
    private Double toleranceS;
    @Column(name = "TOLERANCEPB")
    private Double tolerancePb;
    @Column(name = "TOLERANCEP")
    private Double toleranceP;
    @Column(name = "TOLERANCESI")
    private Double toleranceSi;
    @Column(name = "TYPICAL_UNITMO", length = 4000)
    private String typical_unitMO;
    @Column(name = "TYPICAL_UNITCU", length = 4000)
    private String typical_unitCU;
    @Column(name = "TYPICAL_UNITC", length = 4000)
    private String typical_unitC;
    @Column(name = "TYPICAL_UNITS", length = 4000)
    private String typical_unitS;
    @Column(name = "TYPICAL_UNITPB", length = 4000)
    private String typical_unitPb;
    @Column(name = "TYPICAL_UNITP", length = 4000)
    private String typical_unitP;
    @Column(name = "TYPICAL_UNITSI", length = 4000)
    private String typical_unitSi;
    @Column(name = "DISCOUNTVALUEONE")
    private Double discountValueOne;
    @Column(name = "DISCOUNTVALUEONE_1")
    private Double discountValueOne_1;
    @Column(name = "DISCOUNTVALUEONE_2")
    private Double discountValueOne_2;
    @Column(name = "DISCOUNTVALUETWO")
    private Double discountValueTwo;
    @Column(name = "DISCOUNTVALUETWO_1")
    private Double discountValueTwo_1;
    @Column(name = "DISCOUNTVALUETWO_2")
    private Double discountValueTwo_2;
    @Column(name = "DISCOUNTVALUETHREE")
    private Double discountValueThree;
    @Column(name = "DISCOUNTVALUETHREE_1")
    private Double discountValueThree_1;
    @Column(name = "DISCOUNTVALUETHREE_2")
    private Double discountValueThree_2;
    @Column(name = "DISCOUNTVALUEFOUR")
    private Double discountValueFour;
    @Column(name = "DISCOUNTVALUEFOUR_1")
    private Double discountValueFour_1;
    @Column(name = "DISCOUNTVALUEFOUR_2")
    private Double discountValueFour_2;
    @Column(name = "DISCOUNTVALUEFIVE")
    private Double discountValueFive;
    @Column(name = "DISCOUNTVALUEFIVE_1")
    private Double discountValueFive_1;
    @Column(name = "DISCOUNTVALUEFIVE_2")
    private Double discountValueFive_2;
    @Column(name = "DISCOUNTVALUESIX")
    private Double discountValueSix;
    @Column(name = "DISCOUNTVALUESIX_1")
    private Double discountValueSix_1;
    @Column(name = "DISCOUNTVALUESIX_2")
    private Double discountValueSix_2;
    @Column(name = "DISCOUNTVALUESEVEN")
    private Double discountValueSeven;
    @Column(name = "DISCOUNTVALUESEVEN_1")
    private Double discountValueSeven_1;
    @Column(name = "DISCOUNTVALUESEVEN_2")
    private Double discountValueSeven_2;
    @Column(name = "DISCOUNTVALUEEIGHT")
    private Double discountValueEight;
    @Column(name = "DISCOUNTVALUEEIGHT_1")
    private Double discountValueEight_1;
    @Column(name = "DISCOUNTVALUEEIGHT_2")
    private Double discountValueEight_2;
    @Column(name = "DISCOUNTVALUENINE")
    private Double discountValueNine;
    @Column(name = "DISCOUNTVALUENINE_1")
    private Double discountValueNine_1;
    @Column(name = "DISCOUNTVALUENINE_2")
    private Double discountValueNine_2;
    @Column(name = "DISCOUNTVALUETEN")
    private Double discountValueTen;
    @Column(name = "DISCOUNTVALUETEN_1")
    private Double discountValueTen_1;
    @Column(name = "DISCOUNTVALUETEN_2")
    private Double discountValueTen_2;
    @Column(name = "DISCOUNTVALUEELEVEN")
    private Double discountValueEleven;
    @Column(name = "DISCOUNTVALUEELEVEN_1")
    private Double discountValueEleven_1;
    @Column(name = "DISCOUNTVALUEELEVEN_2")
    private Double discountValueEleven_2;
    @Column(name = "DISCOUNTFOR", length = 4000)
    private String discountFor;
    @Column(name = "DISCOUNTPERFIXONE", length = 4000)
    private String discountPerfixOne;
    @Column(name = "DISCOUNTUNITONE", length = 4000)
    private String discountUnitOne;
    @Column(name = "DISCOUNTPERFIXONE_1", length = 4000)
    private String discountPerfixOne_1;
    @Column(name = "DISCOUNTPERFIXTWO", length = 4000)
    private String discountPerfixTwo;
    @Column(name = "DISCOUNTUNITTWO", length = 4000)
    private String discountUnitTwo;
    @Column(name = "DISCOUNTPERFIXTWO_1", length = 4000)
    private String discountPerfixTwo_1;
    @Column(name = "DISCOUNTPERFIXTHREE", length = 4000)
    private String discountPerfixThree;
    @Column(name = "DISCOUNTPERFIXTHREE_1", length = 4000)
    private String discountPerfixThree_1;
    @Column(name = "DISCOUNTUNITFOUR", length = 4000)
    private String discountUnitFour;
    @Column(name = "DISCOUNTPERFIXFOUR_1", length = 4000)
    private String discountPerfixFour_1;
    @Column(name = "DISCOUNTPERFIXFIVE", length = 4000)
    private String discountPerfixFive;
    @Column(name = "DISCOUNTUNITFIVE", length = 4000)
    private String discountUnitFive;
    @Column(name = "DISCOUNTPERFIXFIVE_1", length = 4000)
    private String discountPerfixFive_1;
    @Column(name = "DISCOUNTPERFIXSIX", length = 4000)
    private String discountPerfixSix;
    @Column(name = "DISCOUNTUNITSIX", length = 4000)
    private String discountUnitSix;
    @Column(name = "DISCOUNTPERFIXSIX_1", length = 4000)
    private String discountPerfixSix_1;
    @Column(name = "DISCOUNTPERFIXSEVEN", length = 4000)
    private String discountPerfixSeven;
    @Column(name = "DISCOUNTUNITSEVEN", length = 4000)
    private String discountUnitSeven;
    @Column(name = "DISCOUNTPERFIXSEVEN_1", length = 4000)
    private String discountPerfixSeven_1;
    @Column(name = "DISCOUNTPERFIXEIGHT", length = 4000)
    private String discountPerfixEight;
    @Column(name = "DISCOUNTUNITEIGHT", length = 4000)
    private String discountUnitEight;
    @Column(name = "DISCOUNTPERFIXEIGHT_1", length = 4000)
    private String discountPerfixEight_1;
    @Column(name = "DISCOUNTPERFIXNINE", length = 4000)
    private String discountPerfixNine;
    @Column(name = "DISCOUNTUNITNINE", length = 4000)
    private String discountUnitNine;
    @Column(name = "DISCOUNTPERFIXNINE_1", length = 4000)
    private String discountPerfixNine_1;
    @Column(name = "DISCOUNTPERFIXTEN", length = 4000)
    private String discountPerfixTen;
    @Column(name = "DISCOUNTUNITTEN", length = 4000)
    private String discountUnitTen;
    @Column(name = "DISCOUNTPERFIXTEN_1", length = 4000)
    private String discountPerfixTen_1;
    @Column(name = "DISCOUNTPERFIXELEVEN", length = 4000)
    private String discountPerfixEleven;
    @Column(name = "DISCOUNTUNITELEVEN", length = 4000)
    private String discountUnitEleven;
    @Column(name = "DISCOUNTPERFIXELEVEN_1", length = 4000)
    private String discountPerfixEleven_1;
    @Column(name = "ARTICLE10_NUMBER56", length = 4000)
    private String article10_number56;
    @Column(name = "ARTICLE10_NUMBER57", length = 4000)
    private String article10_number57;
    @Column(name = "ARTICLE10_NUMBER58", length = 4000)
    private String article10_number58;
    @Column(name = "ARTICLE10_NUMBER59", length = 4000)
    private String article10_number59;
    @Column(name = "ARTICLE10_NUMBER60", length = 4000)
    private String article10_number60;
    @Column(name = "ARTICLE10_NUMBER61")
    private Double article10_number61;

    @Getter
    @EqualsAndHashCode(callSuper = false)
    @Embeddable
    public static class ContractDetailAuditId implements Serializable {
        @Column(name = "ID")
        private Long id;

        @Column(name = "REV")
        private Long rev;
    }

}
