package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IInvoiceSalesService;
import com.nicico.sales.model.entities.base.InvoiceSales;
import com.nicico.sales.repository.InvoiceSalesDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class InvoiceSalesService extends GenericService<InvoiceSales, Long, InvoiceSalesDTO.Create, InvoiceSalesDTO.Info, InvoiceSalesDTO.Update, InvoiceSalesDTO.Delete> implements IInvoiceSalesService {

    private final OAuth2RestTemplate restTemplate;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional
    @Override
    @Action(value = ActionType.Create)
    public InvoiceSalesDTO.Info create(InvoiceSalesDTO.Create request) {
        final InvoiceSales invoiceSales = modelMapper.map(request, InvoiceSales.class);
        InvoiceSales last = null;
        if (((InvoiceSalesDAO) repository).findBySerialOrderByCreatedDateDesc(invoiceSales.getSerial()).size() != 0)
            last = ((InvoiceSalesDAO) repository).findBySerialOrderByCreatedDateDesc(invoiceSales.getSerial()).get(0);
        if (last == null)
            invoiceSales.setInvoiceNo("0");
        else
            invoiceSales.setInvoiceNo(String.valueOf(Integer.parseInt(last.getInvoiceNo()) + 1));
//        getDetailContactInformation(invoiceSales.getCustomerId());
        return save(invoiceSales);
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    void getDetailContactInformation(Long id) {
        restTemplate.getForEntity("http://localhost:8090/accounting" + "/rest/detail/" + id, String.class);
    }

}
