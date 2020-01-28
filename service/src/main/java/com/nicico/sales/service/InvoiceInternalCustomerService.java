package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceInternalCustomerDTO;
import com.nicico.sales.iservice.IInvoiceInternalCustomerService;
import com.nicico.sales.model.entities.base.InvoiceInternalCustomer;
import com.nicico.sales.repository.InvoiceInternalCustomerDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceInternalCustomerService implements IInvoiceInternalCustomerService {

    private final ModelMapper modelMapper;
    private final InvoiceInternalCustomerDAO invoiceInternalCustomerDAO;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL_CUSTOMER')")
    public InvoiceInternalCustomerDTO.Info get(Long id) {
        final InvoiceInternalCustomer invoiceInternalCustomer = invoiceInternalCustomerDAO.findById(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceInternalCustomerNotFound));

        return modelMapper.map(invoiceInternalCustomer, InvoiceInternalCustomerDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL_CUSTOMER')")
    public List<InvoiceInternalCustomerDTO.Info> list() {
        final List<InvoiceInternalCustomer> slAll = invoiceInternalCustomerDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<InvoiceInternalCustomerDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_INVOICE_INTERNAL_CUSTOMER')")
    public InvoiceInternalCustomerDTO.Info create(InvoiceInternalCustomerDTO.Create request) {
        final InvoiceInternalCustomer invoiceInternalCustomer = modelMapper.map(request, InvoiceInternalCustomer.class);

        final Optional<InvoiceInternalCustomer> invoiceInternalCustomer1 = invoiceInternalCustomerDAO.findById(request.getId());
        if (invoiceInternalCustomer != null)
            throw new SalesException(SalesException.ErrorType.DuplicateRecord);

        return save(invoiceInternalCustomer);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_INVOICE_INTERNAL_CUSTOMER')")
    public InvoiceInternalCustomerDTO.Info update(Long id, InvoiceInternalCustomerDTO.Update request) {
        final InvoiceInternalCustomer invoiceInternalCustomer = invoiceInternalCustomerDAO.findById(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));

        InvoiceInternalCustomer updating = new InvoiceInternalCustomer();
        modelMapper.map(invoiceInternalCustomer, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_INVOICE_INTERNAL_CUSTOMER')")
    public void delete(Long id) {
        invoiceInternalCustomerDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_INVOICE_INTERNAL_CUSTOMER')")
    public void delete(InvoiceInternalCustomerDTO.Delete request) {
        final List<InvoiceInternalCustomer> indices = invoiceInternalCustomerDAO.findAllById(request.getIds());

        invoiceInternalCustomerDAO.deleteAll(indices);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_INTERNAL_CUSTOMER')")
    public TotalResponse<InvoiceInternalCustomerDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(invoiceInternalCustomerDAO, criteria, invoiceInternalCustomer -> modelMapper.map(invoiceInternalCustomer, InvoiceInternalCustomerDTO.Info.class));
    }

    @Transactional(readOnly = true)
    public InvoiceInternalCustomerDTO.Info getByCustomerId(String id) {
        final InvoiceInternalCustomer invoiceInternalCustomer = invoiceInternalCustomerDAO.findByCustomerId(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceInternalCustomerNotFound));

        return modelMapper.map(invoiceInternalCustomer, InvoiceInternalCustomerDTO.Info.class);
    }

    private InvoiceInternalCustomerDTO.Info save(InvoiceInternalCustomer invoiceInternalCustomer) {
        final InvoiceInternalCustomer saved = invoiceInternalCustomerDAO.saveAndFlush(invoiceInternalCustomer);
        return modelMapper.map(saved, InvoiceInternalCustomerDTO.Info.class);
    }
}
