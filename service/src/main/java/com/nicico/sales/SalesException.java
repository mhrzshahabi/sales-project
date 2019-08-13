package com.nicico.sales;

import com.nicico.copper.common.IErrorCode;
import com.nicico.copper.common.NICICOException;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
public class SalesException extends NICICOException {

	@Getter
	@RequiredArgsConstructor
	public enum ErrorType implements IErrorCode {
        ContractIncomeCostNotFound(404),
		CostNotFound(404),
		InvoiceNotFound(404),
		ContractShipmentNotFound(404),
		DailyReportBandarAbbasNotFound(404),
		TozinNotFound(404),
		TozinSalesNotFound(404),
		BolHeaderNotFound(404),
		BolItemNotFound(404),
		ContactNotFound(404),
		ContactAccountNotFound(404),
		ContractNotFound(404),
		ContractAddendumNotFound(404),
		ContractAttachmentNotFound(404),
		ContractCurrencyNotFound(404),
		ContractItemNotFound(404),
		ContractItemAddendumNotFound(404),
		ContractItemFeatureNotFound(404),
		ContractItemShipmentNotFound(404),
		ContractPenaltyNotFound(404),
		ContractPersonNotFound(404),
		CurrencyNotFound(404),
		CurrencyRateNotFound(404),
		DailyWarehouseNotFound(404),
		DCCNotFound(404),
		ExportNotFound(404),
		FeatureNotFound(404),
		GlossaryNotFound(404),
		GroupsNotFound(404),
		GroupsPersonNotFound(404),
		IncotermsNotFound(404),
		InspectionContractNotFound(404),
		InstructionNotFound(404),
		LMENotFound(404),
		MaterialNotFound(404),
		MaterialFeatureNotFound(404),
		ParametersNotFound(404),
		PaymentOptionNotFound(404),
		PaymentOptionContractNotFound(404),
		PersonNotFound(404),
		PortNotFound(404),
		ProvisionalInvoiceNotFound(404),
		RateNotFound(404),
		ShipmentNotFound(404),
		ShipmentAssayHeaderNotFound(404),
		ShipmentAssayItemNotFound(404),
		ShipmentContractNotFound(404),
		ShipmentEmailNotFound(404),
		ShipmentHeaderNotFound(404),
		ShipmentInquiryNotFound(404),
		ShipmentMoistureHeaderNotFound(404),
		ShipmentMoistureItemNotFound(404),
		ShipmentPriceNotFound(404),
		ShipmentResourceNotFound(404),
		UnitNotFound(404),
		WarehouseLotNotFound(404),
		CountryNotFound(404),
		BankNotFound(404);

		private final Integer httpStatusCode;

		@Override
		public String getName() {
			return name();
		}
	}

	// ------------------------------

	public SalesException(IErrorCode errorCode) {
		super(errorCode);
	}

	public SalesException(ErrorType errorCode) {
		this(errorCode, null);
	}

	public SalesException(ErrorType errorCode, String field) {
		super(errorCode, field);
	}
}
