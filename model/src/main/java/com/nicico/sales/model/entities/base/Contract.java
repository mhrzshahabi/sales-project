package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.Incoterm;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Cascade;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Audited
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CONTRACT")
public class Contract extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT")
    @SequenceGenerator(name = "SEQ_CONTRACT", sequenceName = "SEQ_CONTRACT", allocationSize = 1)
    @Column(name = "CONTRACT_ID")
    private Long id;

    @Column(name = "C_ADDENDUM")
    private String addendum;

    @Column(name = "C_ADDENDUM_DESC", length = 1000)
    private String addendumDesc;

    @Column(name = "C_ADDENDUM_DATE")
    private String addendumDate;

    @Column(name = "C_CONTRACT_NO", nullable = false)
    private String contractNo;

    @Column(name = "C_CONTRACT_DATE")
    private String contractDate;

    @Column(name = "C_SIDE_CONTRACT_NO")
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
    private Incoterm incoterms;

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

    @NotAudited
    @OneToOne(mappedBy = "contract", fetch = FetchType.LAZY)
    @Cascade({org.hibernate.annotations.CascadeType.PERSIST})
    private ContractDetail contractDetails;

    @NotAudited
    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false)
    private List<ContractShipment> contractShipments;

//    @NotAudited
//    @OneToMany(mappedBy = "contract", fetch = FetchType.LAZY)
//    private List<Shipment> shipments;

}
