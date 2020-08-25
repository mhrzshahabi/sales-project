package com.nicico.sales.service;

import com.nicico.sales.dto.InvoiceDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IInvoiceService;
import com.nicico.sales.model.entities.base.Invoice;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@RequiredArgsConstructor
@Service
public class InvoiceService extends GenericService<Invoice, Long, InvoiceDTO.Create, InvoiceDTO.Info, InvoiceDTO.Update, InvoiceDTO.Delete> implements IInvoiceService {

    private final OAuth2RestTemplate restTemplate;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;


    @Transactional
    @Override
    public InvoiceDTO.Info sendForm2accounting(Long id, String data) {
        final Invoice invoice = repository.findById(id)
                .orElseThrow(() -> new NotFoundException(Invoice.class));
        ResponseEntity<String> processId = restTemplate.postForEntity(accountingAppUrl + "/rest/workflow/startSalesProcess", data, String.class);
        invoice.setProcessId(processId.getBody());
        return save(invoice);
    }

}
