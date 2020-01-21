package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.IncotermsDTO;
import com.nicico.sales.iservice.IIncotermsService;
import com.nicico.sales.model.entities.base.Incoterms;
import com.nicico.sales.repository.IncotermsDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class IncotermsService implements IIncotermsService {

    private final IncotermsDAO incotermsDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_INCOTERMS')")
    public IncotermsDTO.Info get(Long id) {
        final Optional<Incoterms> slById = incotermsDAO.findById(id);
        final Incoterms incoterms = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.IncotermsNotFound));

        return modelMapper.map(incoterms, IncotermsDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INCOTERMS')")
    public List<IncotermsDTO.Info> list() {
        final List<Incoterms> slAll = incotermsDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<IncotermsDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_INCOTERMS')")
    public IncotermsDTO.Info create(IncotermsDTO.Create request) {
        final Incoterms incoterms = modelMapper.map(request, Incoterms.class);

        return save(incoterms);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_INCOTERMS')")
    public IncotermsDTO.Info update(Long id, IncotermsDTO.Update request) {
        final Optional<Incoterms> slById = incotermsDAO.findById(id);
        final Incoterms incoterms = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.IncotermsNotFound));

        Incoterms updating = new Incoterms();
        modelMapper.map(incoterms, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INCOTERMS')")
    public void delete(Long id) {
        incotermsDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INCOTERMS')")
    public void delete(IncotermsDTO.Delete request) {
        final List<Incoterms> incotermss = incotermsDAO.findAllById(request.getIds());

        incotermsDAO.deleteAll(incotermss);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INCOTERMS')")
    public SearchDTO.SearchRs<IncotermsDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(incotermsDAO, request, incoterms -> modelMapper.map(incoterms, IncotermsDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INCOTERMS')")
    public TotalResponse<IncotermsDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(incotermsDAO, criteria, incoterms -> modelMapper.map(incoterms, IncotermsDTO.Info.class));
    }

    private IncotermsDTO.Info save(Incoterms incoterms) {
        final Incoterms saved = incotermsDAO.saveAndFlush(incoterms);
        return modelMapper.map(saved, IncotermsDTO.Info.class);
    }
}
