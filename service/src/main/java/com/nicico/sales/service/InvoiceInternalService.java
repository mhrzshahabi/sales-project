package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceInternalDTO;
import com.nicico.sales.iservice.IInvoiceInternalService;
import com.nicico.sales.model.entities.base.InvoiceInternal;
import com.nicico.sales.repository.InvoiceInternalDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class InvoiceInternalService implements IInvoiceInternalService {

    private final ModelMapper modelMapper;
    private final InvoiceInternalDAO invoiceInternalDAO;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;


    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL')")
    public InvoiceInternalDTO.Info get(Long id) {
        final InvoiceInternal invoiceInternal = invoiceInternalDAO.findById(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceInternalNotFound));
        return modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class);
    }

    public List<InvoiceInternalDTO.Info> getIds(List id) {
        final List<InvoiceInternal>  allByIds= invoiceInternalDAO.findAllById(id);
        List<InvoiceInternalDTO.Info> invoiceInternalDTOS=new ArrayList<InvoiceInternalDTO.Info>();
        for (InvoiceInternal invoiceInternal:allByIds ) {
            invoiceInternalDTOS.add(modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class));
        }
        return invoiceInternalDTOS;
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL')")
    public List<InvoiceInternalDTO.Info> list() {
        final List<InvoiceInternal> slAll = invoiceInternalDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<InvoiceInternalDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_INVOICE_INTERNAL')")
    public InvoiceInternalDTO.Info create(InvoiceInternalDTO.Create request) {
        final InvoiceInternal invoiceInternal = modelMapper.map(request, InvoiceInternal.class);

        return save(invoiceInternal);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_INVOICE_INTERNAL')")
    public InvoiceInternalDTO.Info update(Long id, InvoiceInternalDTO.Update request) {
        final InvoiceInternal invoiceInternal = invoiceInternalDAO.findById(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));

        InvoiceInternal updating = new InvoiceInternal();
        modelMapper.map(invoiceInternal, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INVOICE_INTERNAL')")
    public void delete(Long id) {
        invoiceInternalDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INVOICE_INTERNAL')")
    public void delete(InvoiceInternalDTO.Delete request) {
        final List<InvoiceInternal> indices = invoiceInternalDAO.findAllById(request.getIds());

        invoiceInternalDAO.deleteAll(indices);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL')")
    public TotalResponse<InvoiceInternalDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(invoiceInternalDAO, criteria, invoiceInternal -> modelMapper.map(invoiceInternal, InvoiceInternalDTO.Info.class));
    }

    @Transactional
    @Override
    public InvoiceInternalDTO.Info sendInternalForm2accounting(Long id, String data) {
        final InvoiceInternal invoice = invoiceInternalDAO.findById(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceNotFound));
        invoice.setProcessId(data);
        return save(invoice);
    }

    private InvoiceInternalDTO.Info save(InvoiceInternal invoiceInternal) {
        final InvoiceInternal saved = invoiceInternalDAO.saveAndFlush(invoiceInternal);
        return modelMapper.map(saved, InvoiceInternalDTO.Info.class);
    }
}
