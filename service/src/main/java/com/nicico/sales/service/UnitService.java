package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.iservice.IUnitService;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.repository.UnitDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class UnitService implements IUnitService {

    private final UnitDAO unitDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_UNIT')")
    public UnitDTO.Info get(Long id) {
        final Optional<Unit> slById = unitDAO.findById(id);
        final Unit unit = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.UnitNotFound));

        return modelMapper.map(unit, UnitDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_UNIT')")
    public List<UnitDTO.Info> list() {
        final List<Unit> slAll = unitDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<UnitDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_UNIT')")
    public UnitDTO.Info create(UnitDTO.Create request) {
        final Unit unit = modelMapper.map(request, Unit.class);

        return save(unit);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_UNIT')")
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
    @PreAuthorize("hasAuthority('D_UNIT')")
    public void delete(Long id) {
        unitDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_UNIT')")
    public void delete(UnitDTO.Delete request) {
        final List<Unit> units = unitDAO.findAllById(request.getIds());

        unitDAO.deleteAll(units);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_UNIT')")
    public TotalResponse<UnitDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(unitDAO, criteria, unit -> modelMapper.map(unit, UnitDTO.Info.class));
    }

    private UnitDTO.Info save(Unit unit) {
        final Unit saved = unitDAO.saveAndFlush(unit);
        return modelMapper.map(saved, UnitDTO.Info.class);
    }

    @Transactional
    @Override
    public void updateUnits() {
        List<Object[]> allUnitsFromViewForUpdate = unitDAO.getAllUnitsFromViewForUpdate();
        Map<Long, String> unitsFetchedForUpdate = new HashMap<>();
        allUnitsFromViewForUpdate.stream()
                .forEach((Object[] u) -> unitsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<Unit> unitListForUpdate = unitDAO.findAllById(unitsFetchedForUpdate.keySet());
        unitListForUpdate.stream()
                .forEach(u -> u.setNameFA(unitsFetchedForUpdate.get(u.getId())));
        List<Object[]> allUnitsFromViewForInsert = unitDAO.getAllUnitsFromViewForInsert();
        unitListForUpdate.addAll(allUnitsFromViewForInsert
                .stream()
                .map(u -> new Unit()
                        .setId(Long.valueOf(u[0].toString()))
                        .setNameFA(u[1].toString()))
                .collect(Collectors.toList()));
        unitDAO.saveAll(unitListForUpdate);
    }
}
