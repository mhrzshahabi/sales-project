package com.nicico.sales.utility;

public class AccountingTotalResponse {
    private AccountingGridResponse response;

    public AccountingTotalResponse() {
    }

    public AccountingTotalResponse(AccountingGridResponse response) {
        this.response = response != null ? response : new AccountingGridResponse(null);
    }

    public AccountingGridResponse getResponse() {
        return response;
    }

    public void setResponse(AccountingGridResponse response) {
        this.response = response;
    }
}
