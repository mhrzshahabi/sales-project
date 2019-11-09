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


}