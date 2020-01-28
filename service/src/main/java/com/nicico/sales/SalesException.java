package com.nicico.sales;

import com.nicico.copper.common.IErrorCode;
import com.nicico.copper.common.NICICOException;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
public class SalesException extends NICICOException {

    public SalesException(IErrorCode errorCode) {
        super(errorCode);
    }


    public SalesException(ErrorType errorCode) {
        this(errorCode, null);
    }

    public SalesException(ErrorType errorCode, String field) {
        super(errorCode, field);
    }

    @Getter
    @RequiredArgsConstructor
    public enum ErrorType implements IErrorCode {
        CatodListNotFound(404),
        WarehouseIssueConsNotFound(404),
        WarehouseIssueMoNotFound(404),
        WarehouseIssueCathodeNotFound(404),
        WarehouseStockNotFound(404),
        MaterialItemNotFound(404),
        WarehouseYardNotFound(404),
        ContractDetailNotFound(404),
        WarehouseCadItemNotFound(404),
        WarehouseCadNotFound(404),
        DuplicateRecord(403),
        CostNotFound(404),
        InvoiceNotFound(404),
        ContractShipmentNotFound(404),
        TozinNotFound(404),
        TozinSalesNotFound(404),
        ContactNotFound(404),
        ContactAccountNotFound(404),
        ContractNotFound(404),
        ContractCurrencyNotFound(404),
        ContractPenaltyNotFound(404),
        ContractPersonNotFound(404),
        CurrencyNotFound(404),
        CurrencyRateNotFound(404),
        DCCNotFound(404),
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
        PersonNotFound(404),
        PortNotFound(404),
        ProvisionalInvoiceNotFound(404),
        RateNotFound(404),
        ShipmentNotFound(404),
        ShipmentAssayHeaderNotFound(404),
        ShipmentAssayItemNotFound(404),
        ShipmentContractNotFound(404),
        ShipmentEmailNotFound(404),
        ShipmentMoistureHeaderNotFound(404),
        ShipmentMoistureItemNotFound(404),
        UnitNotFound(404),
        WarehouseLotNotFound(404),
        CountryNotFound(404),
        InvoiceMolybdenumNotFound(404),
        InvoiceItemNotFound(404),
        InvoiceInternalNotFound(404),
        InvoiceInternalLcNotFound(404),
        InvoiceInternalCustomerNotFound(404),
        BankNotFound(404),
        AccessDenied(403);

        private final Integer httpStatusCode;

        @Override
        public String getName() {
            return name();
        }
    }
}
