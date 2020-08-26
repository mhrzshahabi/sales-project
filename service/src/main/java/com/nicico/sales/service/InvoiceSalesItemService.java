package com.nicico.sales.service;

import com.nicico.sales.dto.InvoiceSalesItemDTO;
import com.nicico.sales.iservice.IInvoiceSalesItemService;
import com.nicico.sales.model.entities.base.InvoiceSalesItem;
import com.nicico.sales.repository.InvoiceSalesItemDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;


@RequiredArgsConstructor
@Service
public class InvoiceSalesItemService extends GenericService<InvoiceSalesItem, Long, InvoiceSalesItemDTO.Create, InvoiceSalesItemDTO.Info, InvoiceSalesItemDTO.Update, InvoiceSalesItemDTO.Delete> implements IInvoiceSalesItemService {
    @Override
    public List<InvoiceSalesItem> findByInvoiceSalesId(Long id) {
        return ((InvoiceSalesItemDAO) repository).findByInvoiceSalesId(id);
    }
}
