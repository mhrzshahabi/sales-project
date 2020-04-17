package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceSalesItemDTO;
import com.nicico.sales.iservice.IInvoiceSalesItemService;
import com.nicico.sales.model.entities.base.InvoiceSalesItem;
import com.nicico.sales.repository.InvoiceSalesItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceSalesItemService implements IInvoiceSalesItemService {

    private final InvoiceSalesItemDAO invoiceSalesItemDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_SALES_ITEM')")
    public InvoiceSalesItemDTO.Info get(Long id) {
        final Optional<InvoiceSalesItem> slById = invoiceSalesItemDAO.findById(id);
        final InvoiceSalesItem invoiceSalesItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceSalesItemNotFound));

        return modelMapper.map(invoiceSalesItem, InvoiceSalesItemDTO.Info.class);
    }


    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_SALES_ITEM')")
    public List<InvoiceSalesItemDTO.Info> list() {
        final List<InvoiceSalesItem> slAll = invoiceSalesItemDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<InvoiceSalesItemDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_INVOICE_SALES_ITEM')")
    public InvoiceSalesItemDTO.Info create(InvoiceSalesItemDTO.Create request) {
        final InvoiceSalesItem invoiceSalesItem = modelMapper.map(request, InvoiceSalesItem.class);

        return save(invoiceSalesItem);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_INVOICE_SALES_ITEM')")
    public InvoiceSalesItemDTO.Info update(Long id, InvoiceSalesItemDTO.Update request) {
        final Optional<InvoiceSalesItem> slById = invoiceSalesItemDAO.findById(id);
        final InvoiceSalesItem invoiceSalesItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceSalesItemNotFound));

        InvoiceSalesItem updating = new InvoiceSalesItem();
        modelMapper.map(invoiceSalesItem, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }


    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_INVOICE_SALES_ITEM')")
    public void delete(Long id) {
        invoiceSalesItemDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_INVOICE_SALES_ITEM')")
    public void delete(InvoiceSalesItemDTO.Delete request) {
        final List<InvoiceSalesItem> invoiceSalesItems = invoiceSalesItemDAO.findAllById(request.getIds());

        invoiceSalesItemDAO.deleteAll(invoiceSalesItems);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_SALES_ITEM')")
    public TotalResponse<InvoiceSalesItemDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(invoiceSalesItemDAO, criteria, invoiceSalesItem -> modelMapper.map(invoiceSalesItem, InvoiceSalesItemDTO.Info.class));
    }

    private InvoiceSalesItemDTO.Info save(InvoiceSalesItem invoiceSalesItem) {
        final InvoiceSalesItem saved = invoiceSalesItemDAO.saveAndFlush(invoiceSalesItem);
        return modelMapper.map(saved, InvoiceSalesItemDTO.Info.class);
    }
}
