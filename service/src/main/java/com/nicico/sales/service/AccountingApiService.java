package com.nicico.sales.service;

import com.nicico.sales.iservice.IAccountingApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class AccountingApiService implements IAccountingApiService {

    @Value("${spring.application.name}")
    private String appName;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    private final OAuth2RestTemplate restTemplate;

    @Override
    public void sendDataParameter() {
        final String url = accountingAppUrl + "/" + appName + "/فروش";
        final HttpHeaders httpHeaders = new HttpHeaders();
        final HttpEntity httpEntity = new HttpEntity(httpHeaders);

        final Map<String, String> requestParams = new HashMap<>();
        requestParams.put("id", "شناسه صورتحساب");
        requestParams.put("bankGroupDesc", "بانک اعتبار");
        requestParams.put("buyerId", "شناسه فروشنده");
        requestParams.put("customerCostCenterCode", "کد مرکز هزينه مشتري");
        requestParams.put("customerId", "شناسه خريدار");
        requestParams.put("customerName", "خریدار");
        requestParams.put("hasPollution", "عوارض صنايع");
        requestParams.put("hasTax", "ماليات و عوارض؟");
        requestParams.put("invoiceAreaPollution", "آلايندگي");
        requestParams.put("invoiceContainerName", "نام ظرف");
        requestParams.put("invoiceContainerNumber", "تعدادظرف");
        requestParams.put("invoiceContainerWeight", "وزن ظرف");
        requestParams.put("invoiceDate", "تاریخ ايجاد");
        requestParams.put("invoiceGrossWeight", "وزن ناخالص");
        requestParams.put("invoiceLatinDesc", "شرح لاتین صورتحساب");
        requestParams.put("invoiceOtherDeductions", "کسورات دیگر");
        requestParams.put("invoicePersianDesc", "شرح فارسی صورتحساب");
        requestParams.put("invoiceRealWeight", "وزن محاسبه شده");
        requestParams.put("invoiceSalesType", "نوع فروش");
        requestParams.put("invoiceSent", "T/F شناسه دارد و يا ندارد");
        requestParams.put("invoiceSerial", "سریال(سال||شمارنده)");
        requestParams.put("invoiceTotalTax", "ماليات و عوارض");
        requestParams.put("invoiceTotalWeight", "وزن کل صورتحساب");
        requestParams.put("invoiceUnitPrice", "قيمت هر کيلو ريال نهايي صورتحساب");
        requestParams.put("invoiceValueAdded", "ارزش افزوده");
        requestParams.put("lcCostCenterCode", "کد مرکز هزينه ال سي");
        requestParams.put("lcDueDate", "تاريخ سرسيد ال سي");
        requestParams.put("lcId", "شناسه ال سي ");
        requestParams.put("nosaBankCode", "شناسه بانک (نوسا)");
        requestParams.put("nosaCustomerCode", "شناسه مشتري(نوسا)");
        requestParams.put("nosaCustomerCreditCode", "کد اعتباري مشتري(نوسا)");
        requestParams.put("nosaPollutionCode", "کد نوع عوارض");
        requestParams.put("nosaProductCode", "کد عوارض آلايندگي 103/18 (نوسا)");
        requestParams.put("nosaProductGroupCode", "کد نوسا گروه");
        requestParams.put("nosaTaxCode", "کد نوع عوارض(نوسا)");
        requestParams.put("percentage", "درصد (اعتباري/نقدي)");
        requestParams.put("pollutionChargeAmount", "عوارض صنايع");
        requestParams.put("pollutionCostCenterCode", "کد مرکز هزينه عوارض");
        requestParams.put("productCostCenterCode", "کد هزينه آلايندگي");
        requestParams.put("productGroupName", "شرح گروه");
        requestParams.put("productId", "شناسه محصول");
        requestParams.put("productName", "محصول");
        requestParams.put("realWeight", "وزن محاسبه شده");
        requestParams.put("remittanceAmount", "مقدار حواله");
        requestParams.put("remittanceFinalDate", "تاريخ خاتمه حواله");
        requestParams.put("remittanceId", "شناسه حواله");
        requestParams.put("salesType", "شرایط فروش");
        requestParams.put("taxChargeAmount", "ماليات و عوارض");
        requestParams.put("taxCostCenterCode", "کد مرکز هزينه عوارض(نوسا)");
        requestParams.put("TotalAmount", "مبلغ کل فروش");
        requestParams.put("totalDeductions", "جمع مالیات و عوارض");
        requestParams.put("unitId", "خالی");
        requestParams.put("unitPrice", "قيمت هر کيلو ريال ثبت در حواله");

        final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class, requestParams);
        if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
            System.out.println(httpResponse.getBody());
        } else {
            throw new RuntimeException("Exception: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
        }
    }
}
