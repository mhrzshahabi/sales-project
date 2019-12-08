package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.CatodListDTO;
import com.nicico.sales.iservice.ICatodListService;
import com.nicico.sales.model.entities.base.CatodList;
import com.nicico.sales.repository.CatodListDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class CatodListService implements ICatodListService {

    private final CatodListDAO catodListDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_CATODLIST')")
    public CatodListDTO.Info get(Long id) {
        final Optional<CatodList> slById = catodListDAO.findById(id);
        final CatodList catodList = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CatodListNotFound));

        return modelMapper.map(catodList, CatodListDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CATODLIST')")
    public List<CatodListDTO.Info> list() {
        final List<CatodList> slAll = catodListDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<CatodListDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_CATODLIST')")
    public CatodListDTO.Info create(CatodListDTO.Create request) {
        final CatodList catodList = modelMapper.map(request, CatodList.class);

        return save(catodList);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_CATODLIST')")
    public CatodListDTO.Info update(Long id, CatodListDTO.Update request) {
        final Optional<CatodList> slById = catodListDAO.findById(id);
        final CatodList catodList = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CatodListNotFound));

        CatodList updating = new CatodList();
        modelMapper.map(catodList, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CATODLIST')")
    public void delete(Long id) {
        catodListDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CATODLIST')")
    public void delete(CatodListDTO.Delete request) {
        final List<CatodList> catodLists = catodListDAO.findAllById(request.getIds());

        catodListDAO.deleteAll(catodLists);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CATODLIST')")
    public TotalResponse<CatodListDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(catodListDAO, criteria, catodList -> modelMapper.map(catodList, CatodListDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CATODLIST')")
    public SearchDTO.SearchRs<CatodListDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(catodListDAO, request, entity -> modelMapper.map(entity, CatodListDTO.Info.class));
    }

    private CatodListDTO.Info save(CatodList catodList) {
        final CatodList saved = catodListDAO.saveAndFlush(catodList);
        return modelMapper.map(saved, CatodListDTO.Info.class);
    }
}
