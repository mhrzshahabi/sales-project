package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.iservice.IInvoiceSalesService;
import com.nicico.sales.model.entities.base.InvoiceSales;
import com.nicico.sales.repository.InvoiceSalesDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceSalesService implements IInvoiceSalesService {

    private final InvoiceSalesDAO invoiceSalesDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_SALES')")
    public InvoiceSalesDTO.Info get(Long id) {
        final Optional<InvoiceSales> slById = invoiceSalesDAO.findById(id);
        final InvoiceSales invoiceSales = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceSalesNotFound));

        return modelMapper.map(invoiceSales, InvoiceSalesDTO.Info.class);
    }


    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_SALES')")
    public List<InvoiceSalesDTO.Info> list() {
        final List<InvoiceSales> slAll = invoiceSalesDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<InvoiceSalesDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_INVOICE_SALES')")
    public InvoiceSalesDTO.Info create(InvoiceSalesDTO.Create request) {
        final InvoiceSales invoiceSales = modelMapper.map(request, InvoiceSales.class);
        InvoiceSales last = invoiceSalesDAO.findBySerialOrderByCreatedDateDesc(invoiceSales.getSerial()).get(0);
        if (last == null)
            invoiceSales.setInvoiceNo("0");
        else
            invoiceSales.setInvoiceNo(String.valueOf(Integer.parseInt(last.getInvoiceNo()) + 1));
        return save(invoiceSales);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_INVOICE_SALES')")
    public InvoiceSalesDTO.Info update(Long id, InvoiceSalesDTO.Update request) {
        final Optional<InvoiceSales> slById = invoiceSalesDAO.findById(id);
        final InvoiceSales invoiceSales = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceSalesNotFound));

        InvoiceSales updating = new InvoiceSales();
        modelMapper.map(invoiceSales, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }


    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_INVOICE_SALES')")
    public void delete(Long id) {
        invoiceSalesDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_INVOICE_SALES')")
    public void delete(InvoiceSalesDTO.Delete request) {
        final List<InvoiceSales> invoiceSales = invoiceSalesDAO.findAllById(request.getIds());

        invoiceSalesDAO.deleteAll(invoiceSales);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_SALES')")
    public TotalResponse<InvoiceSalesDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(invoiceSalesDAO, criteria, invoiceSales -> modelMapper.map(invoiceSales, InvoiceSalesDTO.Info.class));
    }

    private InvoiceSalesDTO.Info save(InvoiceSales invoiceSales) {
        final InvoiceSales saved = invoiceSalesDAO.saveAndFlush(invoiceSales);
        return modelMapper.map(saved, InvoiceSalesDTO.Info.class);
    }
}
