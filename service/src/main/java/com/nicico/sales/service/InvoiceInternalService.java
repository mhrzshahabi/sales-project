package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.dto.InternalInvoiceDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IInternalInvoiceService;
import com.nicico.sales.iservice.IInvoiceInternalService;
import com.nicico.sales.model.entities.base.InternalInvoiceDocument;
import com.nicico.sales.model.entities.base.ViewInternalInvoiceDocument;
import com.nicico.sales.repository.InternalInvoiceDAO;
import com.nicico.sales.repository.InternalInvoiceDocumentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RequiredArgsConstructor
@Service
public class InvoiceInternalService extends GenericService<ViewInternalInvoiceDocument, String, InternalInvoiceDTO.Create, InternalInvoiceDTO.Info, InternalInvoiceDTO.Update, InternalInvoiceDTO.Delete> implements IInvoiceInternalService {

    private final InternalInvoiceDocumentDAO internalInvoiceDocumentDAO;
    private final IInternalInvoiceService internalInvoiceService;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;


    @Transactional(readOnly = true)
    @Override
    @Action(value = ActionType.Get)
    public InternalInvoiceDTO.Info get(String id) {
        final ViewInternalInvoiceDocument invoiceInternal = repository.findById(id)
                .orElseThrow(() -> new NotFoundException(ViewInternalInvoiceDocument.class));
        return modelMapper.map(invoiceInternal, InternalInvoiceDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @Action(value = ActionType.List)
    public List<InternalInvoiceDTO.Info> getIds(List<String> id) {
        final List<ViewInternalInvoiceDocument> allByIds = repository.findAllById(id);
        List<InternalInvoiceDTO.Info> invoiceInternalDTOS = new ArrayList<InternalInvoiceDTO.Info>();
        for (ViewInternalInvoiceDocument invoiceInternal : allByIds) {
            invoiceInternalDTOS.add(modelMapper.map(invoiceInternal, InternalInvoiceDTO.Info.class));
        }
        return invoiceInternalDTOS;
    }

    @Transactional
    @Override
    @Action(value = ActionType.Create)
    public InternalInvoiceDTO.Info sendInternalForm2accounting(String id, String data) {
        InternalInvoiceDocument invoice = new InternalInvoiceDocument();
//        invoice.setInvId(id);
//        invoice.setProcessId(data);
        return save(invoice);
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update , authority = "hasAuthority('E_UPDATE_INVOICE_INTERNAL_DOC_ID')")
    public void updateDeletedDocument(List<InternalInvoiceDTO.Info> data) {

        AccountingDTO.DocumentStatusRq request = new AccountingDTO.DocumentStatusRq();
        request.setDocumentIds(data.stream().map(InternalInvoiceDTO::getDocumentId).collect(Collectors.toList()));
        internalInvoiceService.updateInvoiceIdsStatus("sales internal invoice", request);
    }

    private InternalInvoiceDTO.Info save(InternalInvoiceDocument internalInvoiceDocument) {
        final InternalInvoiceDocument saved = internalInvoiceDocumentDAO.saveAndFlush(internalInvoiceDocument);
        return modelMapper.map(saved, InternalInvoiceDTO.Info.class);
    }
}
