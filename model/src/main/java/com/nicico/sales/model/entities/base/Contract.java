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
@Table(name = "TBL_CONTRACT")
public class Contract extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT")
	@SequenceGenerator(name = "SEQ_CONTRACT", sequenceName = "SEQ_CONTRACT")
	@Column(name = "ID")
	private Long id;

	@Column(name = "C_ADDENDUM", length = 200)
	private String addendum;

	@Column(name = "C_ADDENDUM_DESC", length = 1000)
	private String addendumDesc;

	@Column(name = "C_ADDENDUM_DATE", length = 20)
	private String addendumDate;

	@Column(name = "C_CONTRACT_NO", nullable = false, length = 200)
	private String contractNo;

	@Column(name = "C_CONTRACT_DATE", length = 20)
	private String contractDate;

	@Column(name = "C_SIDE_CONTRACT_NO", length = 200)
	private String sideContractNo;

	@Column(name = "C_SIDE_CONTRACT_DATE", length = 20)
	private String sideContractDate;

	@Column(name = "C_IS_COMPLETE", length = 2)
	private String isComplete;

	@Column(name = "C_DESCL", length = 4000)
	private String descl;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTACT_ID", insertable = false, updatable = false)
	private Contact contact;

	@Column(name = "CONTACT_ID")
	private Long contactId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SELLER_AGENT_ID", insertable = false, updatable = false)
	private Contact contactBySellerAgent;

	@Column(name = "SELLER_AGENT_ID")
	private Long contactBySellerAgentId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BUYER_AGENT_ID", insertable = false, updatable = false)
	private Contact contactByBuyerAgent;

	@Column(name = "BUYER_AGENT_ID")
	private Long contactByBuyerAgentId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BUYER_ID", insertable = false, updatable = false)
	private Contact contactByBuyer;

	@Column(name = "BUYER_ID")
	private Long contactByBuyerId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "DEFINITION_ID", insertable = false, updatable = false)
	private Parameters parameterByDefinition;

	@Column(name = "DEFINITION_ID")
	private Long parameterByDefinitionId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INCOTERMS_ID", insertable = false, updatable = false)
	private Incoterms incoterms;

	@Column(name = "INCOTERMS_ID")
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

	@Column(name = "INCOTERMS")
	private String incotermsText;

	@Column(name = "OFFICE_SOURCE")
	private String officeSource;

	@Column(name = "PUBLISH_TIME")
	private String publishTime;

	@Column(name = "REPORT_TITLE")
	private String reportTitle;

	@Column(name = "DELAY")
	private String delay;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PORT_SOURCE_ID", insertable = false, updatable = false)
	private Contact portByPortSource;

	@Column(name = "PORT_SOURCE_ID")
	private Long portByPortSourceId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ID", insertable = false, updatable = false)
	private Material material;

	@Column(name = "MATERIAL_ID")
	private Long materialId;

	@Column(name = "AMOUNT", nullable = false, length = 20)
	private Double amount;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UNIT_ID", insertable = false, updatable = false)
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


}
