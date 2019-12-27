package com.nicico.sales.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceDTO;
import com.nicico.sales.dto.InvoiceItemDTO;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;
import com.nicico.sales.iservice.IInvoiceItemService;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import com.nicico.sales.iservice.IInvoiceService;
import com.nicico.sales.model.entities.base.InvoiceMolybdenum;
import com.nicico.sales.repository.InvoiceMolybdenumDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceMolybdenumService implements IInvoiceMolybdenumService {

    private final InvoiceMolybdenumDAO invoiceMolybdenumDAO;
    private final IInvoiceItemService invoiceItemService;
    private final IInvoiceService invoiceService;
    private final ModelMapper modelMapper;
    private final ObjectMapper objectMapper;

    @Transactional(readOnly = true)
    public InvoiceMolybdenumDTO.Info get(Long id) {
        final Optional<InvoiceMolybdenum> slById = invoiceMolybdenumDAO.findById(id);
        final InvoiceMolybdenum invoiceMolybdenumMolybdenum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceMolybdenumNotFound));

        return modelMapper.map(invoiceMolybdenumMolybdenum, InvoiceMolybdenumDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<InvoiceMolybdenumDTO.Info> list() {
        final List<InvoiceMolybdenum> slAll = invoiceMolybdenumDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<InvoiceMolybdenumDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    public void molybdenum(String data) throws IOException {
        String[] data_ = data.split("@abaspour@"); // mo  up  down

        InvoiceDTO.Info invoice = objectMapper.readValue(data_[3], InvoiceDTO.Info.class);

        if (invoice.getId() == null) {
            InvoiceDTO.Create c = new InvoiceDTO.Create();
            modelMapper.map(invoice, c);
            invoice = invoiceService.create(c);
        } else {
            InvoiceDTO.Update u = new InvoiceDTO.Update();
            modelMapper.map(invoice, u);
            invoice = invoiceService.update(u.getId(), u);
        }
        List<InvoiceMolybdenumDTO.Info> molybdenumInfoList = objectMapper.readValue(data_[0], new TypeReference<List<InvoiceMolybdenumDTO.Info>>() {
        });

        for (InvoiceMolybdenumDTO.Info info : molybdenumInfoList) {
            if (info.getId() == null) {
                InvoiceMolybdenumDTO.Create cc = new InvoiceMolybdenumDTO.Create();
                modelMapper.map(info, cc);
                cc.setInvoiceId(invoice.getId());
                create(cc);
            } else {
                if (info.getLotNo() == null) {
                    delete(info.getId());
                } else {
                    InvoiceMolybdenumDTO.Update uu = new InvoiceMolybdenumDTO.Update();
                    modelMapper.map(info, uu);
                    uu.setInvoiceId(invoice.getId());
                    update(info.getId(), uu);
                }
            }
        }
        List<InvoiceItemDTO.Info> upInfoList = objectMapper.readValue(data_[1], new TypeReference<List<InvoiceItemDTO.Info>>() {
        });

        for (InvoiceItemDTO.Info info : upInfoList) {
            if (info.getId() == null) {
                InvoiceItemDTO.Create cc = new InvoiceItemDTO.Create();
                modelMapper.map(info, cc);
                cc.setInvoiceId(invoice.getId());
                invoiceItemService.create(cc);
            } else {
                if (info.getDescription() == null) {
                    invoiceItemService.delete(info.getId());
                } else {
                    InvoiceItemDTO.Update uu = new InvoiceItemDTO.Update();
                    modelMapper.map(info, uu);
                    uu.setInvoiceId(invoice.getId());
                    invoiceItemService.update(info.getId(), uu);
                }
            }
        }
    }

    @Transactional
    @Override
    public InvoiceMolybdenumDTO.Info create(InvoiceMolybdenumDTO.Create request) {
        final InvoiceMolybdenum invoiceMolybdenum = modelMapper.map(request, InvoiceMolybdenum.class);

        return save(invoiceMolybdenum);
    }

    @Transactional
    @Override
    public InvoiceMolybdenumDTO.Info update(Long id, InvoiceMolybdenumDTO.Update request) {
        final Optional<InvoiceMolybdenum> slById = invoiceMolybdenumDAO.findById(id);
        final InvoiceMolybdenum invoiceMolybdenum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceMolybdenumNotFound));

        InvoiceMolybdenum updating = new InvoiceMolybdenum();
        modelMapper.map(invoiceMolybdenum, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    public void delete(Long id) {
        invoiceMolybdenumDAO.deleteById(id);
    }

    @Transactional
    @Override
    public void delete(InvoiceMolybdenumDTO.Delete request) {
        final List<InvoiceMolybdenum> invoiceMolybdenums = invoiceMolybdenumDAO.findAllById(request.getIds());

        invoiceMolybdenumDAO.deleteAll(invoiceMolybdenums);
    }

    @Transactional(readOnly = true)
    @Override
    public TotalResponse<InvoiceMolybdenumDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(invoiceMolybdenumDAO, criteria, instruction -> modelMapper.map(instruction, InvoiceMolybdenumDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    public SearchDTO.SearchRs<InvoiceMolybdenumDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(invoiceMolybdenumDAO, request, invoiceMolybdenum -> modelMapper.map(invoiceMolybdenum, InvoiceMolybdenumDTO.Info.class));
    }

    private InvoiceMolybdenumDTO.Info save(InvoiceMolybdenum invoiceMolybdenum) {
        final InvoiceMolybdenum saved = invoiceMolybdenumDAO.saveAndFlush(invoiceMolybdenum);
        return modelMapper.map(saved, InvoiceMolybdenumDTO.Info.class);
    }
}
