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
@Table(name = "TBL_INVOICE_SALES")
public class InvoiceSales extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE_SALES")
    @SequenceGenerator(name = "SEQ_INVOICE_SALES", sequenceName = "SEQ_INVOICE_SALES", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "SERIAL")
    private String serial;

    @Column(name = "INVOICE_NO")
    private String invoiceNo;

    @Column(name = "INVOICE_DATE")
    private String invoiceDate;

    @Column(name = "DISTRICT")
    private String district;

    @Column(name = "CUSTOMER_ID")
    private Long customerId;

    @Column(name = "CUSTOMER_NAME")
    private String customerName;

//    @Column(name = "SALES_TYPE_ID")
//    private Long salesTypeId;

    @Column(name = "SALES_TYPE_NAME")
    private String salesTypeName;

//    @Column(name = "CURRENCY")
//    private String currency;

//    @Column(name = "CONTAMINATION_TAXES_ID")
//    private Long contaminationTaxesId;

    @Column(name = "CONTAMINATION_TAXES_NAME")
    private String contaminationTaxesName;

//    @Column(name = "PAYMENT_TYPE_ID")
//    private Long paymentTypeId;

    @Column(name = "PAYMENT_TYPE_NAME")
    private String paymentTypeName;

    @Column(name = "LC_NO_ID")
    private Long lcNoId;

    @Column(name = "LC_NO_NAME")
    private String lcNoName;

    @Column(name = "PRE_INVOICE_ID")
    private Long preInvoiceId;

    @Column(name = "PRE_INVOICE_DATE")
    private String preInvoiceDate;

    @Column(name = "ISSUE_ID")
    private Long issueId;

    @Column(name = "ISSUE_DATE")
    private String issueDate;

//    @Column(name = "OPENING_BANK_ID")
//    private Long openingBankId;
//
//    @Column(name = "OPENING_DATE")
//    private String openingDate;

//    @Column(name = "DEALER_BANK_ID")
//    private Long dealerBankId;
//
//    @Column(name = "DEALER_BANK_NAME")
//    private String dealerBankName;

    @Column(name = "OTHER_DESCRIPTION")
    private String otherDescription;

    @Column(name = "FIRST_CONTRACT_NO")
    private String firstContractNo;

    @Column(name = "SECOND_CONTRACT_NO")
    private String secondContractNo;

    @Column(name = "SECOND_CONTRACT_NAME")
    private String secondContractName;


}
