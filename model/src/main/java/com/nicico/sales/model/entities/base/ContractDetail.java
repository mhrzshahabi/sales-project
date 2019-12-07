package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CONTRACT_DETAIL")
public class ContractDetail extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_DETAIL")
    @SequenceGenerator(name = "SEQ_CONTRACT_DETAIL", sequenceName = "SEQ_CONTRACT_DETAIL", allocationSize = 1)
    @Column(name = "id")
    private Long ID;
    @Column(name = "CONTRACT_ID")
    private Long contract_id;
    @Column(name = "NAME_CONTACTAGENTSELLER", length = 500)
    private String name_ContactAgentSeller;
    @Column(name = "PHONE_CONTACTAGENTSELLER", length = 500)
    private String phone_ContactAgentSeller;
    @Column(name = "MOBILE_CONTACTAGENTSELLER", length = 500)
    private String mobile_ContactAgentSeller;
    @Column(name = "ADDRESS_CONTACTAGENTSELLER", length = 500)
    private String address_ContactAgentSeller;
    @Column(name = "NAME_CONTACTSELLER", length = 500)
    private String name_ContactSeller;
    @Column(name = "PHONE_CONTACTSELLER", length = 500)
    private String phone_ContactSeller;
    @Column(name = "MOBILE_CONTACTSELLER", length = 500)
    private String mobile_ContactSeller;
    @Column(name = "ADDRESS_CONTACTSELLER", length = 500)
    private String address_ContactSeller;
    @Column(name = "NAME_CONTACTAGENTBUYER", length = 500)
    private String name_ContactAgentBuyer;
    @Column(name = "PHONE_CONTACTAGENTBUYER", length = 500)
    private String phone_ContactAgentBuyer;
    @Column(name = "MOBILE_CONTACTAGENTBUYER", length = 500)
    private String mobile_ContactAgentBuyer;
    @Column(name = "ADDRESS_CONTACTAGENTBUYER", length = 500)
    private String address_ContactAgentBuyer;
    @Column(name = "NAME_CONTACTBUYER", length = 500)
    private String name_ContactBuyer;
    @Column(name = "PHONE_CONTACTBUYER", length = 500)
    private String phone_ContactBuyer;
    @Column(name = "MOBILE_CONTACTBUYER", length = 500)
    private String mobile_ContactBuyer;
    @Column(name = "ADDRESS_CONTACTBUYER", length = 500)
    private String address_ContactBuyer;
    @Column(name = "FEILD_ALL_DEFINITIONS_SAVE", length = 500)
    private String feild_all_defintitons_save;

    @Column(name = "ARTICLE2_13_1", length = 500)
    private String article2_13_1;
    @Column(name = "RESPONSIBLETELERONS", length = 500)
    private String responsibleTelerons;
    @Column(name = "ARTICLE3_NUMBER17", length = 500)
    private String article3_number17;
    @Column(name = "ARTICLE3_NUMBER17_7", length = 500)
    private String article3_number17_7;
    @Column(name = "ARTICLE3_NUMBER17_8", length = 500)
    private String article3_number17_8;
    @Column(name = "ARTICLE3_NUMBER17_9", length = 500)
    private String article3_number17_9;
    @Column(name = "ARTICLE3_NUMBER17_10", length = 500)
    private String article3_number17_10;
    @Column(name = "ARTICLE3_NUMBER17_11", length = 500)
    private String article3_number17_11;
    @Column(name = "ARTICLE3_NUMBER17_12", length = 500)
    private String article3_number17_12;
    @Column(name = "ARTICLE3_NUMBER17_2", length = 500)
    private String article3_number17_2;
    @Column(name = "ARTICLE3_NUMBER17_3", length = 500)
    private String article3_number17_3;
    @Column(name = "ARTICLE3_NUMBER17_4", length = 500)
    private String article3_number17_4;
    @Column(name = "ARTICLE3_NUMBER17_5", length = 500)
    private String article3_number17_5;
    @Column(name = "ARTICLE3_NUMBER17_6", length = 500)
    private String article3_number17_6;
    @Column(name = "ARTICLE4_NUMBER18", length = 500)
    private String article4_number18;
    @Column(name = "AMOUNT_NUMBER19_1", length = 500)
    private String amount_number19_1;
    @Column(name = "AMOUNT_NUMBER19_2", length = 500)
    private String amount_number19_2;
    @Column(name = "SHIPMENT_NUMBER20", length = 500)
    private String shipment_number20;
    @Column(name = "ARTICLE5_NUMBER21_6", length = 500)
    private String article5_number21_6;
    @Column(name = "ARTICLE5_NOTE1_LABLE", length = 500)
    private String article5_Note1_lable;
    @Column(name = "ARTICLE5_NOTE1_VALUE", length = 500)
    private String article5_Note1_value;
    @Column(name = "ARTICLE6_NUMBER31", length = 500)
    private String article6_number31;
    @Column(name = "ARTICLE6_NUMBER31_1", length = 500)
    private String article6_number31_1;
    @Column(name = "ARTICLE6_NUMBER32_1", length = 500)
    private String article6_number32_1;
    @Column(name = "ARTICLE6_NUMBER34", length = 500)
    private String article6_number34;
    @Column(name = "ARTICLE6_CONTAINERIZED", length = 500)
    private String article6_Containerized;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER36_1", length = 500)
    private String article6_Containerized_number36_1;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER33", length = 500)
    private String article6_Containerized_number33;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER37_1", length = 500)
    private String article6_Containerized_number37_1;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER37_2", length = 500)
    private String article6_Containerized_number37_2;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER33_1", length = 500)
    private String article6_Containerized_number33_1;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER37_3", length = 500)
    private String article6_Containerized_number37_3;
    @Column(name = "ARTICLE6_CONTAINERIZED_NUMBER32", length = 500)
    private String article6_Containerized_number32;
    @Column(name = "ARTICLE6_CONTAINERIZED_4", length = 500)
    private String article6_Containerized_4;
    @Column(name = "ARTICLE6_CONTAINERIZED_5", length = 500)
    private String article6_Containerized_5;
    @Column(name = "ARTICLE7_NUMBER41", length = 500)
    private String article7_number41;
    @Column(name = "ARTICLE7_NUMBER3", length = 500)
    private String article7_number3;
    @Column(name = "ARTICLE7_NUMBER37", length = 500)
    private String article7_number37;
    @Column(name = "ARTICLE7_NUMBER3_1", length = 500)
    private String article7_number3_1;
    @Column(name = "ARTICLE7_NUMBER40_2", length = 500)
    private String article7_number40_2;
    @Column(name = "ARTICLE7_NUMBER40_3", length = 500)
    private String article7_number40_3;
    @Column(name = "ARTICLE8_NUMBER42", length = 500)
    private String article8_number42;
    @Column(name = "ARTICLE8_3", length = 500)
    private String article8_3;
    @Column(name = "ARTICLE8_VALUE", length = 500)
    private String article8_value;
    @Column(name = "ARTICLE8_NUMBER43", length = 500)
    private String article8_number43;
    @Column(name = "ARTICLE8_NUMBER44_1", length = 500)
    private String article8_number44_1;
    @Column(name = "ARTICLE8_NUMBER45", length = 500)
    private String article9_number45;
    @Column(name = "ARTICLE9_NUMBER22", length = 500)
    private String article9_number22;
    @Column(name = "ARTICLE9_ENGLISHI_NUMBER22", length = 500)
    private String article9_Englishi_number22;
    @Column(name = "ARTICLE9_NUMBER23", length = 500)
    private String article9_number23;
    @Column(name = "ARTICLE9_NUMBER48", length = 500)
    private String article9_number48;
    @Column(name = "ARTICLE9_NUMBER49_1", length = 500)
    private String article9_number49_1;
    @Column(name = "ARTICLE9_NUMBER51", length = 500)
    private String article9_number51;
    @Column(name = "ARTICLE9_NUMBER54", length = 500)
    private String article9_number54;
    @Column(name = "ARTICLE9_NUMBER54_1", length = 500)
    private String article9_number54_1;
    @Column(name = "ARTICLE9_NUMBER55", length = 500)
    private String article9_number55;
    @Column(name = "ARTICLE9_IMPORTANTNOTE", length = 500)
    private String article9_ImportantNote;
    @Column(name = "STRING_CURRENCY", length = 500)
    private String string_Currency;
    @Column(name = "TYPICAL_C", length = 500)
    private Integer typical_c;
    @Column(name = "TYPICAL_S", length = 500)
    private Integer typical_s;
    @Column(name = "TYPICAL_PB", length = 500)
    private Integer typical_pb;
    @Column(name = "TYPICAL_P", length = 500)
    private Integer typical_p;
    @Column(name = "TYPICAL_SI", length = 500)
    private Integer typical_Si;
    @Column(name = "TYPICAL_SIZE_MIN", length = 500)
    private String typical_size_min;
    @Column(name = "PREFIXMOLYBDENUM", length = 500)
    private String PrefixMolybdenum;
    @Column(name = "PREFIXCOPPER", length = 500)
    private String PrefixCopper;
    @Column(name = "PREFIXC", length = 500)
    private String PrefixC;
    @Column(name = "PREFIXS", length = 500)
    private String PrefixS;
    @Column(name = "PREFIXPB", length = 500)
    private String PrefixPb;
    @Column(name = "PREFIXP", length = 500)
    private String PrefixP;
    @Column(name = "PREFIXSI", length = 500)
    private String PrefixSi;
    @Column(name = "TOLERANCEMO", length = 500)
    private Integer toleranceMO;
    @Column(name = "TOLERANCECU", length = 500)
    private Integer toleranceCU;
    @Column(name = "TOLERANCEC", length = 500)
    private Integer toleranceC;
    @Column(name = "TOLERANCES", length = 500)
    private Integer toleranceS;
    @Column(name = "TOLERANCEPB", length = 500)
    private Integer tolerancePb;
    @Column(name = "TOLERANCEP", length = 500)
    private Integer toleranceP;
    @Column(name = "TOLERANCESI", length = 500)
    private Integer toleranceSi;
    @Column(name = "TYPICAL_UNITMO", length = 500)
    private String typical_unitMO;
    @Column(name = "TYPICAL_UNITCU", length = 500)
    private String typical_unitCU;
    @Column(name = "TYPICAL_UNITC", length = 500)
    private String typical_unitC;
    @Column(name = "TYPICAL_UNITS", length = 500)
    private String typical_unitS;
    @Column(name = "TYPICAL_UNITPB", length = 500)
    private String typical_unitPb;
    @Column(name = "TYPICAL_UNITP", length = 500)
    private String typical_unitP;
    @Column(name = "TYPICAL_UNITSI", length = 500)
    private String typical_unitSi;
    @Column(name = "DISCOUNTVALUEONE", length = 500)
    private Integer discountValueOne;
    @Column(name = "DISCOUNTVALUEONE_1", length = 500)
    private Integer discountValueOne_1;
    @Column(name = "DISCOUNTVALUEONE_2", length = 500)
    private Integer discountValueOne_2;
    @Column(name = "DISCOUNTVALUETWO", length = 500)
    private Integer discountValueTwo;
    @Column(name = "DISCOUNTVALUETWO_1", length = 500)
    private Integer discountValueTwo_1;
    @Column(name = "DISCOUNTVALUETWO_2", length = 500)
    private Integer discountValueTwo_2;
    @Column(name = "DISCOUNTVALUETHREE", length = 500)
    private Integer discountValueThree;
    @Column(name = "DISCOUNTVALUETHREE_1", length = 500)
    private Integer discountValueThree_1;
    @Column(name = "DISCOUNTVALUETHREE_2", length = 500)
    private Integer discountValueThree_2;
    @Column(name = "DISCOUNTVALUEFOUR", length = 500)
    private Integer discountValueFour;
    @Column(name = "DISCOUNTVALUEFOUR_1", length = 500)
    private Integer discountValueFour_1;
    @Column(name = "DISCOUNTVALUEFOUR_2", length = 500)
    private Integer discountValueFour_2;
    @Column(name = "DISCOUNTVALUEFIVE", length = 500)
    private Integer discountValueFive;
    @Column(name = "DISCOUNTVALUEFIVE_1", length = 500)
    private Integer discountValueFive_1;
    @Column(name = "DISCOUNTVALUEFIVE_2", length = 500)
    private Integer discountValueFive_2;
    @Column(name = "DISCOUNTVALUESIX", length = 500)
    private Integer discountValueSix;
    @Column(name = "DISCOUNTVALUESIX_1", length = 500)
    private Integer discountValueSix_1;
    @Column(name = "DISCOUNTVALUESIX_2", length = 500)
    private Integer discountValueSix_2;
    @Column(name = "DISCOUNTVALUESEVEN", length = 500)
    private Integer discountValueSeven;
    @Column(name = "DISCOUNTVALUESEVEN_1", length = 500)
    private Integer discountValueSeven_1;
    @Column(name = "DISCOUNTVALUESEVEN_2", length = 500)
    private Integer discountValueSeven_2;
    @Column(name = "DISCOUNTVALUEEIGHT", length = 500)
    private Integer discountValueEight;
    @Column(name = "DISCOUNTVALUEEIGHT_1", length = 500)
    private Integer discountValueEight_1;
    @Column(name = "DISCOUNTVALUEEIGHT_2", length = 500)
    private Integer discountValueEight_2;
    @Column(name = "DISCOUNTVALUENINE", length = 500)
    private Integer discountValueNine;
    @Column(name = "DISCOUNTVALUENINE_1", length = 500)
    private Integer discountValueNine_1;
    @Column(name = "DISCOUNTVALUENINE_2", length = 500)
    private Integer discountValueNine_2;
    @Column(name = "DISCOUNTVALUETEN", length = 500)
    private Integer discountValueTen;
    @Column(name = "DISCOUNTVALUETEN_1", length = 500)
    private Integer discountValueTen_1;
    @Column(name = "DISCOUNTVALUETEN_2", length = 500)
    private Integer discountValueTen_2;
    @Column(name = "DISCOUNTVALUEELEVEN", length = 500)
    private Integer discountValueEleven;
    @Column(name = "DISCOUNTVALUEELEVEN_1", length = 500)
    private Integer discountValueEleven_1;
    @Column(name = "DISCOUNTVALUEELEVEN_2", length = 500)
    private Integer discountValueEleven_2;
    @Column(name = "DISCOUNTFOR", length = 500)
    private String discountFor;
    @Column(name = "DISCOUNTPERFIXONE", length = 500)
    private String discountPerfixOne;
    @Column(name = "DISCOUNTUNITONE", length = 500)
    private String discountUnitOne;
    @Column(name = "DISCOUNTPERFIXONE_1", length = 500)
    private String discountPerfixOne_1;
    @Column(name = "DISCOUNTPERFIXTWO", length = 500)
    private String discountPerfixTwo;
    @Column(name = "DISCOUNTUNITTWO", length = 500)
    private String discountUnitTwo;
    @Column(name = "DISCOUNTPERFIXTWO_1", length = 500)
    private String discountPerfixTwo_1;
    @Column(name = "DISCOUNTPERFIXTHREE", length = 500)
    private String discountPerfixThree;
    @Column(name = "DISCOUNTPERFIXTHREE_1", length = 500)
    private String discountPerfixThree_1;
    @Column(name = "DISCOUNTUNITFOUR", length = 500)
    private String discountUnitFour;
    @Column(name = "DISCOUNTPERFIXFOUR_1", length = 500)
    private String discountPerfixFour_1;
    @Column(name = "DISCOUNTPERFIXFIVE", length = 500)
    private String discountPerfixFive;
    @Column(name = "DISCOUNTUNITFIVE", length = 500)
    private String discountUnitFive;
    @Column(name = "DISCOUNTPERFIXFIVE_1", length = 500)
    private String discountPerfixFive_1;
    @Column(name = "DISCOUNTPERFIXSIX", length = 500)
    private String discountPerfixSix;
    @Column(name = "DISCOUNTUNITSIX", length = 500)
    private String discountUnitSix;
    @Column(name = "DISCOUNTPERFIXSIX_1", length = 500)
    private String discountPerfixSix_1;
    @Column(name = "DISCOUNTPERFIXSEVEN", length = 500)
    private String discountPerfixSeven;
    @Column(name = "DISCOUNTUNITSEVEN", length = 500)
    private String discountUnitSeven;
    @Column(name = "DISCOUNTPERFIXSEVEN_1", length = 500)
    private String discountPerfixSeven_1;
    @Column(name = "DISCOUNTPERFIXEIGHT", length = 500)
    private String discountPerfixEight;
    @Column(name = "DISCOUNTUNITEIGHT", length = 500)
    private String discountUnitEight;
    @Column(name = "DISCOUNTPERFIXEIGHT_1", length = 500)
    private String discountPerfixEight_1;
    @Column(name = "DISCOUNTPERFIXNINE", length = 500)
    private String discountPerfixNine;
    @Column(name = "DISCOUNTUNITNINE", length = 500)
    private String discountUnitNine;
    @Column(name = "DISCOUNTPERFIXNINE_1", length = 500)
    private String discountPerfixNine_1;
    @Column(name = "DISCOUNTPERFIXTEN", length = 500)
    private String discountPerfixTen;
    @Column(name = "DISCOUNTUNITTEN", length = 500)
    private String discountUnitTen;
    @Column(name = "DISCOUNTPERFIXTEN_1", length = 500)
    private String discountPerfixTen_1;
    @Column(name = "DISCOUNTPERFIXELEVEN", length = 500)
    private String discountPerfixEleven;
    @Column(name = "DISCOUNTUNITELEVEN", length = 500)
    private String discountUnitEleven;
    @Column(name = "DISCOUNTPERFIXELEVEN_1", length = 500)
    private String discountPerfixEleven_1;
    @Column(name = "ARTICLE10_NUMBER56", length = 500)
    private String article10_number56;
    @Column(name = "ARTICLE10_NUMBER57", length = 500)
    private String article10_number57;
    @Column(name = "ARTICLE10_NUMBER58", length = 500)
    private String article10_number58;
    @Column(name = "ARTICLE10_NUMBER59", length = 500)
    private String article10_number59;
    @Column(name = "ARTICLE10_NUMBER60", length = 500)
    private String article10_number60;
    @Column(name = "ARTICLE10_NUMBER61", length = 500)
    private Double article10_number61;


}
