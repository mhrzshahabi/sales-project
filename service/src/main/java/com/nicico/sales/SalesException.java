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
        ContractShipmentNotFound(404),
        TozinNotFound(404),
        ContactNotFound(404),
        ContactAccountNotFound(404),
        ContractNotFound(404),
        ContractAuditNotFound(404),
        ContractCurrencyNotFound(404),
        ContractPenaltyNotFound(404),
        ContractPersonNotFound(404),
        CurrencyNotFound(404),
        CurrencyRateNotFound(404),
        DCCNotFound(404),
        GroupsNotFound(404),
        GroupsPersonNotFound(404),
        IncotermsNotFound(404),
        PriceBaseNotFound(404),
        MaterialNotFound(404),
        ParametersNotFound(404),
        PersonNotFound(404),
        PortNotFound(404),
        ProvisionalInvoiceNotFound(404),
        ShipmentNotFound(404),
        ShipmentContractNotFound(404),
        UnitNotFound(404),
        CountryNotFound(404),
        InvoiceMolybdenumNotFound(404),
        InvoiceItemNotFound(404),
        InvoiceInternalNotFound(404),
        BankNotFound(404),
        InvoiceSalesNotFound(404),
        InvoiceSalesItemNotFound(404);

        private final Integer httpStatusCode;

        @Override
        public String getName() {
            return name();
        }
    }
}
