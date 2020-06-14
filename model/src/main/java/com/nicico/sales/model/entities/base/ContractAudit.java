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
                " CONTRACT_ID," +
                "REV," +
                "REVTYPE," +
                "C_CREATED_BY," +
                "D_CREATED_DATE," +
                "C_LAST_MODIFIED_BY," +
                "D_LAST_MODIFIED_DATE," +
                "DP_SELLER," +
                "LP_SELLER," +
                "C_ADDENDUM," +
                "C_ADDENDUM_DATE," +
                "C_ADDENDUM_DESC," +
                "AMOUNT," +
                "AMOUNT_EN," +
                "BUYER_AGENT_ID," +
                "SELLER_AGENT_ID," +
                "SELLER_ID," +
                "CONTACT_ID," +
                "CONTACT_INSPECTION_ID," +
                "CONTENT_TYPE," +
                "C_CONTRACT_DATE," +
                "C_CONTRACT_NO," +
                "COPPER," +
                "GCOPPER_TOLORANCE," +
                "DELAY," +
                "DESC_NOT," +
                "C_DESCL," +
                "DISCOUNT," +
                "DRAFT_DP_WEIGHTREF," +
                "DRAFT_LP_WEIGHTREF," +
                "EVENT_PAYMENT," +
                "FINAL_DP_WEIGHT," +
                "FINAL_LP_WEIGHT," +
                "GOLD," +
                "GOLD_TOLORANCE," +
                "INCOTERMS_ID," +
                "INCOTERMS," +
                "INPECTION_DP," +
                "INPECTION_LP," +
                "INSPECTION_COST_DST," +
                "INSPECTION_COST_SRC," +
                "INVOICE," +
                "INVOICE_TYPE," +
                "C_IS_COMPLETE," +
                "MATERIAL_ID," +
                "MO_AMOUNT," +
                "MOISTURE_DP," +
                "MOISTURE_LP," +
                "MOLYBDENUM," +
                "MOLYBDENUM_TOLORANCE," +
                "NO_DAY_FINAL," +
                "OFFICE_SOURCE," +
                "OPTIONAL," +
                "DEFINITION_ID," +
                "PAY_TIME," +
                "CONTRACT_START," +
                "CONTRACT_END," +
                "PORT_SOURCE_ID," +
                "PREFIX_PAYMENT," +
                "PREMIUM," +
                "PREPAID," +
                "PREPAID_CUR," +
                "PRICE_CAL_PERIOD," +
                "PRICE_PERIOD," +
                "PROVISIONAL_COEFFICIENT," +
                "PUBLISH_TIME," +
                "PUBLISHER," +
                "RC," +
                "REPORT_TITLE," +
                "RUN_END_DATE," +
                "RUN_FROM," +
                "RUN_START_DATE," +
                "RUN_TILL," +
                "SAMPLING_DP," +
                "SAMPLING_LP," +
                "C_SIDE_CONTRACT_DATE," +
                "C_SIDE_CONTRACT_NO," +
                "SILVER," +
                "SILVER_TOLORANCE," +
                "TIME_ISSUANCE," +
                "TC," +
                "UNIT_ID," +
                "WEIGHING_DP," +
                "WEIGHING_LP" +
                " FROM" +
                " TBL_CONTRACT_AUD"
)
public class ContractAudit {

    @EmbeddedId
    private ContractAuditId id;
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
    @Column(name = "C_ADDENDUM", length = 200)
    private String addendum;
    @Column(name = "C_ADDENDUM_DESC", length = 1000)
    private String addendumDesc;
    @Column(name = "C_ADDENDUM_DATE", length = 50)
    private String addendumDate;
    @Column(name = "C_CONTRACT_NO", nullable = false, length = 200)
    private String contractNo;
    @Column(name = "C_CONTRACT_DATE", length = 50)
    private String contractDate;
    @Column(name = "C_SIDE_CONTRACT_NO", length = 200)
    private String sideContractNo;
    @Column(name = "C_SIDE_CONTRACT_DATE", length = 50)
    private String sideContractDate;
    @Column(name = "C_IS_COMPLETE", length = 3)
    private String isComplete;
    @Column(name = "C_DESCL", length = 4000)
    private String descl;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2contactByBuyer"))
    private Contact contact; // contactByBuyer
    @Column(name = "CONTACT_ID")
    private Long contactId; // contactByBuyerId
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "SELLER_AGENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2contactBySellerAgent"))
    private Contact contactBySellerAgent;
    @Column(name = "SELLER_AGENT_ID")
    private Long contactBySellerAgentId;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "CONTACT_INSPECTION_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "none", value = ConstraintMode.NO_CONSTRAINT))
    private Contact contactInspection;
    @Column(name = "CONTACT_INSPECTION_ID")
    private Long contactInspectionId;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "BUYER_AGENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2contactByBuyerAgent"))
    private Contact contactByBuyerAgent;
    @Column(name = "BUYER_AGENT_ID")
    private Long contactByBuyerAgentId;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "SELLER_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2contactBySeller"))
    private Contact contactBySeller;
    @Column(name = "SELLER_ID")
    private Long contactBySellerId;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "DEFINITION_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "Contract2parmtrByDefinitin"))
    private Parameters parameterByDefinition;
    @Column(name = "DEFINITION_ID")
    private Long parameterByDefinitionId;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "INCOTERMS_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "Contract2incoterm"))
    private Incoterms incoterms;
    @Column(name = "INCOTERMS_ID", nullable = false)
    private Long incotermsId;
    @Column(name = "INSPECTION_COST_SRC", length = 4)
    private Long inspectionCostPercentSource;
    @Column(name = "INSPECTION_COST_DST", length = 4)
    private Long inspectionCostPercentDest;
    @Column(name = "PROVISIONAL_COEFFICIENT", length = 4)
    private Long provisionalCoefficient;
    @Column(name = "PREPAID", length = 4)
    private Long prepaid;
    @Column(name = "TIME_ISSUANCE")
    private String timeIssuance;
    @Column(name = "INVOICE")
    private Long invoice;
    @Column(name = "INVOICE_TYPE")
    private String invoiceType;
    @Column(name = "RUN_FROM")
    private String runFrom;
    @Column(name = "RUN_START_DATE")
    private String runStartDate;
    @Column(name = "RUN_END_DATE")
    private String runEndtDate;
    @Column(name = "RUN_TILL")
    private String runTill;
    @Column(name = "DESC_NOT")
    private String descNot;
    @Column(name = "PREPAID_CUR", length = 20)
    private String prepaidCurrency;
    @Column(name = "PAY_TIME")
    private String payTime;
    @Column(name = "PRICE_CAL_PERIOD")
    private String priceCalPeriod;
    @Column(name = "PRICE_PERIOD")
    private String pricePeriod;
    @Column(name = "PREFIX_PAYMENT")
    private String prefixPayment;
    @Column(name = "EVENT_PAYMENT")
    private String eventPayment;
    @Column(name = "CONTENT_TYPE")
    private String contentType;
    @Column(name = "PUBLISHER")
    private String publisher;
    @Column(name = "NO_DAY_FINAL")
    private String noDayFinal;
    @Column(name = "INPECTION_LP")
    private Boolean inpectionLP;
    @Column(name = "INPECTION_DP")
    private Boolean inpectionDP;
    @Column(name = "WEIGHING_LP")
    private Boolean weighingLP;
    @Column(name = "WEIGHING_DP")
    private Boolean weighingDP;
    @Column(name = "MOISTURE_LP")
    private Boolean moistureLP;
    @Column(name = "MOISTURE_DP")
    private Boolean moistureDP;
    @Column(name = "SAMPLING_LP")
    private Boolean samplingLP;
    @Column(name = "SAMPLING_DP")
    private Boolean samplingDP;
    @Column(name = "DRAFT_LP_WEIGHTREF")
    private String draftLPWeightRef;
    @Column(name = "DRAFT_DP_WEIGHTREF")
    private String draftDPWeightRef;
    @Column(name = "FINAL_LP_WEIGHT")
    private Boolean finalLPWeight;
    @Column(name = "FINAL_DP_WEIGHT")
    private Boolean finalDPWeight;
    @Column(name = "LP_SELLER")
    private String LPSeller;
    @Column(name = "DP_SELLER")
    private String DPSeller;
    @Column(name = "INCOTERMS_VERSION")
    private Long incotermVersion;
    @Column(name = "OFFICE_SOURCE")
    private String officeSource;
    @Column(name = "PUBLISH_TIME")
    private String publishTime;
    @Column(name = "REPORT_TITLE")
    private String reportTitle;
    @Column(name = "AMOUNT_EN")
    private String amount_en;
    @Column(name = "DELAY")
    private String delay;
    @Column(name = "CONTRACT_START")
    private Date contractStart;
    @Column(name = "CONTRACT_END")
    private Date contractEnd;
    @Column(name = "OPTIONAL")
    private Integer optional;
    @Column(name = "MO_AMOUNT")
    private Double mo_amount;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "PORT_SOURCE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2PortBySourcePortId"))
    private Port portByPortSource;
    @Column(name = "PORT_SOURCE_ID")
    private Long portByPortSourceId;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2materialByMaterialId"))
    private Material material;
    @Column(name = "MATERIAL_ID", nullable = false)
    private Long materialId;
    @Column(name = "AMOUNT")
    private Double amount;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2unitByUnitId"))
    private Unit unit;
    @Column(name = "UNIT_ID")
    private Long unitId;
    @Column(name = "PREMIUM")
    private Double premium;
    @Column(name = "DISCOUNT")
    private Double discount;
    @Column(name = "TC")
    private Double treatCost;
    @Column(name = "RC")
    private Double refinaryCost;
    @Column(name = "GOLD")
    private Double gold;
    @Column(name = "GOLD_TOLORANCE")
    private Double goldTolorance;
    @Column(name = "SILVER")
    private Double silver;
    @Column(name = "SILVER_TOLORANCE")
    private Double silverTolorance;
    @Column(name = "COPPER")
    private Double copper;
    @Column(name = "GCOPPER_TOLORANCE")
    private Double copperTolorance;
    @Column(name = "MOLYBDENUM")
    private Double molybdenum;
    @Column(name = "MOLYBDENUM_TOLORANCE")
    private Double molybdenumTolorance;

    @Getter
    @EqualsAndHashCode(callSuper = false)
    @Embeddable
    public static class ContractAuditId implements Serializable {
        @Column(name = "CONTRACT_ID")
        private Long id;

        @Column(name = "REV")
        private Long rev;
    }


}
