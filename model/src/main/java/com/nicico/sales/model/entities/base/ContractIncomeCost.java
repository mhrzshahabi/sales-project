package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Subselect;
import org.springframework.data.annotation.Immutable;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Subselect("select * from VIEW_CONTRACT_INCOME_COST")
public class ContractIncomeCost extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BANK")
	@SequenceGenerator(name = "SEQ_BANK", sequenceName = "SEQ_BANK")
    @Column(name = "ID")
    private Long id;

    @Column(name = "C_CONTRACT_NO")
    private String contractNo;

    @Column(name = "C_FULLNAME_EN")
    private String customerFullNameEn;

    @Column(name = "C_DESCL")
    private String productNameEn;

    @Column(name = "C_NAME_EN")
    private String unitNameEn;

    @Column(name = "AMOUNT")
    private Double amount;

    @Column(name = "TOTAL_FREIGHT")
    private String totalFreight;

    @Column(name = "SHIPMENT_AMOUNT")
    private Double shipmentAmount;

    @Column(name = "BL_DATE")
    private String blDate;

    @Column(name = "DEMURRAGE")
    private Double demurage;

    @Column(name = "DISPATCH")
    private Double dispatch;

    @Column(name = "FREIGHT")
    private Double freight;

    @Column(name = "LOADING_LETTER")
    private String loadingLetter;

    @Column(name = "MONTH")
    private String month;

    @Column(name = "VESSEL_NAME")
    private String vesselName;

    @Column(name = "INVOIC_DATE_P")
    private String invoceDateProvisional;

    @Column(name = "NET_P")
    private Double netProvisional;

    @Column(name = "INVOICE_TYPE_P")
    private String invoiceTypeProvisional;

    @Column(name = "INVOICE_NO_P")
    private String invoiceNoProvisional;

    @Column(name = "INVOICE_VALUE_P")
    private String invoiceValueProvisional;

    @Column(name = "INVOICE_DOLLAR_P")
    private Double invoiceDollarProvisional;

    @Column(name = "INVOICE_EURO_P")
    private Double invoiceEuroProvisional;

    @Column(name = "INVOICE_IRR_P")
    private Double invoiceIRRProvisional;

    @Column(name = "INVOIC_DATE_F")
    private String invoceDateFinal;

    @Column(name = "NET_F")
    private Double netFinal;

    @Column(name = "INVOICE_TYPE_F")
    private String invoiceTypeFinal;

    @Column(name = "INVOICE_NO_F")
    private String invoiceNoFinal;

    @Column(name = "INVOICE_VALUE_F")
    private String invoiceValueFinal;

    @Column(name = "INVOICE_DOLLAR_F")
    private Double invoiceDollarFinal;

    @Column(name = "INVOICE_EURO_F")
    private Double invoiceEuroFinal;

    @Column(name = "INVOICE_IRR_F")
    private Double invoiceIRRFinal;

    @Column(name = "COST_DOLLAR")
    private Double costDollar;

    @Column(name = "COST_EURO")
    private Double costEuro;

    @Column(name = "COSTS_IRR")
    private Double costIRR;

    @Column(name = "DEST_INSPEC_COST")
    private String destinationInspectionCost;

    @Column(name = "SOURCE_INSPEC_COST")
    private String sourceInspectionCost;

    @Column(name = "INSURANCE_COST")
    private String insuranceCost;

    @Column(name = "UMPIRE_COST")
    private String umpireCost;
}
