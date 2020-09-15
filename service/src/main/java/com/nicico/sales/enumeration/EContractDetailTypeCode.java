package com.nicico.sales.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EContractDetailTypeCode {
    HeaderDetailCode("0"),
    DefinitionDetailCode("1"),
    QuantityDetailCode("2"),
    QualityDetailCode("3"),
    PackingDetailCode("4"),
    ShipmentDetailCode("5"),
    DeliveryTermsDetailCode("6"),
    PriceDetailCode("7"),
    QuotationalPeriodDetailCode("8"),
    PaymentDetailCode("9"),
    CurrencyOptionDetailCode("10"),
    InspectionWeighingDetailCode("11"),
    TitleAndRiskOfLossDetailCode("12"),
    IncotermsDetailCode("13"),
    TaxesDetailCode("14"),
    ForceMajeureDetailCode("15"),
    BankingChargesDetailCode("16"),
    CancellationClause("17"),
    AmendmentsDetailCode("18"),
    ConfidentialityDetailCode("19"),
    AssignmentDetailCode("20"),
    InsuranceDetailCode("21"),
    DamagesDetailCode("22"),
    SuspensionOfQuotationsDetailCode("23"),
    NoticesDetailCode("24"),
    JurisdictionDetailCode("25"),
    EndProvisionsDetailCode("26"),
    FooterDetailCode("27"),
    NoteDetailCode("28"),
    DeductionDetailCode("29");

    private final String id;
}
