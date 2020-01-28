package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.GlossaryDTO;
import com.nicico.sales.iservice.IGlossaryService;
import com.nicico.sales.model.entities.base.Glossary;
import com.nicico.sales.repository.GlossaryDAO;
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
public class GlossaryService implements IGlossaryService {

    private final GlossaryDAO glossaryDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_GLOSSARY')")
    public GlossaryDTO.Info get(Long id) {
        final Optional<Glossary> slById = glossaryDAO.findById(id);
        final Glossary glossary = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.GlossaryNotFound));

        return modelMapper.map(glossary, GlossaryDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_GLOSSARY')")
    public List<GlossaryDTO.Info> list() {
        final List<Glossary> slAll = glossaryDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<GlossaryDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_GLOSSARY')")
    public GlossaryDTO.Info create(GlossaryDTO.Create request) {
        final Glossary glossary = modelMapper.map(request, Glossary.class);

        return save(glossary);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_GLOSSARY')")
    public GlossaryDTO.Info update(Long id, GlossaryDTO.Update request) {
        final Optional<Glossary> slById = glossaryDAO.findById(id);
        final Glossary glossary = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.GlossaryNotFound));

        Glossary updating = new Glossary();
        modelMapper.map(glossary, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_GLOSSARY')")
    public void delete(Long id) {
        glossaryDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_GLOSSARY')")
    public void delete(GlossaryDTO.Delete request) {
        final List<Glossary> glossarys = glossaryDAO.findAllById(request.getIds());

        glossaryDAO.deleteAll(glossarys);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_GLOSSARY')")
    public TotalResponse<GlossaryDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(glossaryDAO, criteria, glossary -> modelMapper.map(glossary, GlossaryDTO.Info.class));
    }

    private GlossaryDTO.Info save(Glossary glossary) {
        final Glossary saved = glossaryDAO.saveAndFlush(glossary);
        return modelMapper.map(saved, GlossaryDTO.Info.class);
    }
}
