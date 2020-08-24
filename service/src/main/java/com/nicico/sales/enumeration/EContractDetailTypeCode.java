package com.nicico.sales.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EContractDetailTypeCode {
	QuantityDetailCode("2"),
	QualityDetailCode("3"),
	PackingDetailCode("4"),
	ShipmentDetailCode("5"),
	DeliveryTermsDetailCode("6"),
	PriceDetailCode("7"),
	QuotationalDPeriodetailCode("8"),
	paymenteeDetailCode("9"),
	CurrencyConversionDetailCode("10"),
	WeightsDetailCode("12");

	// ---------------

	private final String id;
}
