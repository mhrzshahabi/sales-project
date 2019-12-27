package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.iservice.IUnitService;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.repository.UnitDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class UnitService implements IUnitService {

    private final UnitDAO unitDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public UnitDTO.Info get(Long id) {
        final Optional<Unit> slById = unitDAO.findById(id);
        final Unit unit = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.UnitNotFound));

        return modelMapper.map(unit, UnitDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<UnitDTO.Info> list() {
        final List<Unit> slAll = unitDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<UnitDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    public UnitDTO.Info create(UnitDTO.Create request) {
        final Unit unit = modelMapper.map(request, Unit.class);

        return save(unit);
    }

    @Transactional
    @Override
    public UnitDTO.Info update(Long id, UnitDTO.Update request) {
        final Optional<Unit> slById = unitDAO.findById(id);
        final Unit unit = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.UnitNotFound));

        Unit updating = new Unit();
        modelMapper.map(unit, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    public void delete(Long id) {
        unitDAO.deleteById(id);
    }

    @Transactional
    @Override
    public void delete(UnitDTO.Delete request) {
        final List<Unit> units = unitDAO.findAllById(request.getIds());

        unitDAO.deleteAll(units);
    }

    @Transactional(readOnly = true)
    @Override
    public SearchDTO.SearchRs<UnitDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(unitDAO, request, unit -> modelMapper.map(unit, UnitDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_BANK')")
    public TotalResponse<UnitDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(unitDAO, criteria, unit -> modelMapper.map(unit, UnitDTO.Info.class));
    }

    private UnitDTO.Info save(Unit unit) {
        final Unit saved = unitDAO.saveAndFlush(unit);
        return modelMapper.map(saved, UnitDTO.Info.class);
    }
}
