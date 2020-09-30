package com.nicico.sales.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Comparator;

@Getter
@RequiredArgsConstructor
public enum EContractDetailTypeCode {
    Header("Header"),
    Definition("Definition"),
    Quantity("Quantity"),
    Quality("Quality"),
    Packing("Packing"),
    Deduction("Deduction"),
    Shipment("Shipment"),
    DeliveryTerms("DeliveryTerms"),
    Price("Price"),
    QuotationalPeriod("QuotationalPeriod"),
    Payment("Payment"),
    CurrencyOption("CurrencyOption"),
    InspectionWeighing("InspectionWeighing"),
    TitleAndRiskOfLoss("TitleAndRiskOfLoss"),
    Incoterms("Incoterms"),
    Taxes("Taxes"),
    ForceMajeure("ForceMajeure"),
    BankingCharges("BankingCharges"),
    CancellationClause("CancellationClause"),
    Amendments("Amendments"),
    Confidentiality("Confidentiality"),
    Assignment("Assignment"),
    Insurance("Insurance"),
    Damages("Damages"),
    SuspensionOfQuotations("SuspensionOfQuotations"),
    Notices("Notices"),
    Jurisdiction("Jurisdiction"),
    EndProvisions("EndProvisions"),
    Footer("Footer"),
    Note("Note"),
    ExtraArticle("ExtraArticle"),
    ExtraArticle1("ExtraArticle1"),
    ExtraArticle2("ExtraArticle2"),
    ExtraArticle3("ExtraArticle3"),
    ExtraArticle4("ExtraArticle4"),
    ExtraArticle5("ExtraArticle5"),
    Sizing("Sizing");

    private final String id;
}
