package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceInternalDTO;
import com.nicico.sales.iservice.IInvoiceInternalService;
import com.nicico.sales.model.entities.base.InvoiceInternal;
import com.nicico.sales.model.entities.base.InvoiceInternalDocument;
import com.nicico.sales.repository.InvoiceInternalDAO;
import com.nicico.sales.repository.InvoiceInternalDocumentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class InvoiceInternalService implements IInvoiceInternalService {

    private final ModelMapper modelMapper;
    private final InvoiceInternalDAO invoiceInternalDAO;
    private final InvoiceInternalDocumentDAO invoiceInternalDocumentDAO;
    private final EntityManager entityManager;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;


    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL')")
    public InvoiceInternalDTO.Info get(String id) {
        entityManager.createNativeQuery("alter session set nls_language = 'AMERICAN'").executeUpdate();
        final InvoiceInternal invoiceInternal = invoiceInternalDAO.findById(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceInternalNotFound));
        return modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL')")
    public List<InvoiceInternalDTO.Info> getIds(List<String> id) {
        entityManager.createNativeQuery("alter session set nls_language = 'AMERICAN'").executeUpdate();
        final List<InvoiceInternal> allByIds = invoiceInternalDAO.findAllById(id);
        List<InvoiceInternalDTO.Info> invoiceInternalDTOS = new ArrayList<InvoiceInternalDTO.Info>();
        for (InvoiceInternal invoiceInternal : allByIds) {
            invoiceInternalDTOS.add(modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class));
        }
        return invoiceInternalDTOS;
    }


    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL')")
    public List<InvoiceInternalDTO.Info> list() {
        entityManager.createNativeQuery("alter session set nls_language = 'AMERICAN'").executeUpdate();
        final List<InvoiceInternal> slAll = invoiceInternalDAO.findAll();
        return modelMapper.map(slAll, new TypeToken<List<InvoiceInternalDTO.Info>>() {
        }.getType());
    }

    @Transactional(readOnly = true)
    @Override
  //@PreAuthorize("hasAuthority('R_INVOICE_INTERNAL')")
    public TotalResponse<InvoiceInternalDTO.Info> search(NICICOCriteria criteria) {
        entityManager.createNativeQuery("alter session set nls_language = 'AMERICAN'").executeUpdate();
        return SearchUtil.search(invoiceInternalDAO, criteria, invoiceInternal -> modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class));
    }


    @Transactional
    @Override
    public InvoiceInternalDTO.Info sendInternalForm2accounting(String id,String data) {
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
