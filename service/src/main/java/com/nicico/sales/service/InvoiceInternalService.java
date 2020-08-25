package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InvoiceInternalDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IInvoiceInternalService;
import com.nicico.sales.model.entities.base.InvoiceInternal;
import com.nicico.sales.model.entities.base.InvoiceInternalDocument;
import com.nicico.sales.repository.InvoiceInternalDAO;
import com.nicico.sales.repository.InvoiceInternalDocumentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class InvoiceInternalService extends GenericService<InvoiceInternal, String, InvoiceInternalDTO.Create, InvoiceInternalDTO.Info, InvoiceInternalDTO.Update, InvoiceInternalDTO.Delete> implements IInvoiceInternalService {

    private final InvoiceInternalDocumentDAO invoiceInternalDocumentDAO;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;


    @Transactional(readOnly = true)
    @Override
    @Action(value = ActionType.Get)
    public InvoiceInternalDTO.Info get(String id) {
        final InvoiceInternal invoiceInternal = repository.findById(id)
                .orElseThrow(() -> new NotFoundException(InvoiceInternal.class));
        return modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @Action(value = ActionType.List)
    public List<InvoiceInternalDTO.Info> getIds(List<String> id) {
        final List<InvoiceInternal> allByIds = repository.findAllById(id);
        List<InvoiceInternalDTO.Info> invoiceInternalDTOS = new ArrayList<InvoiceInternalDTO.Info>();
        for (InvoiceInternal invoiceInternal : allByIds) {
            invoiceInternalDTOS.add(modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class));
        }
        return invoiceInternalDTOS;
    }

    @Transactional
    @Override
    @Action(value = ActionType.Create)
    public InvoiceInternalDTO.Info sendInternalForm2accounting(String id, String data) {
        InvoiceInternalDocument invoice = new InvoiceInternalDocument();
        invoice.setInvId(id);
        invoice.setProcessId(data);
        return save(invoice);
    }

    private InvoiceInternalDTO.Info save(InvoiceInternalDocument invoiceInternalDocument) {
        final InvoiceInternalDocument saved = invoiceInternalDocumentDAO.saveAndFlush(invoiceInternalDocument);
        return modelMapper.map(saved, InvoiceInternalDTO.Info.class);
    }
}
