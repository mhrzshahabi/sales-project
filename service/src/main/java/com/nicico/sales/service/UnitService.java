package com.nicico.sales.service;


import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.iservice.IUnitService;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.repository.UnitDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@RequiredArgsConstructor
@Service
public class UnitService extends GenericService<Unit, Long, UnitDTO.Create, UnitDTO.Info, UnitDTO.Update, UnitDTO.Delete> implements IUnitService {
    private final UnitDAO dao;
    @Transactional
    @Override
    public void updateUnits() {
        List<Object[]> allUnitsFromViewForUpdate = dao.getAllUnitsFromViewForUpdate();
        Map<Long, String> unitsFetchedForUpdate = new HashMap<>();
        allUnitsFromViewForUpdate.stream()
                .forEach((Object[] u) -> unitsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<Unit> unitListForUpdate = new ArrayList<>();
        unitListForUpdate.addAll(repository.findAllById(unitsFetchedForUpdate.keySet()));
        unitListForUpdate.stream()
                .forEach(u -> u.setNameFA(unitsFetchedForUpdate.get(u.getId())));
        List<Object[]> allUnitsFromViewForInsert = dao.getAllUnitsFromViewForInsert();
        unitListForUpdate.addAll(allUnitsFromViewForInsert
                .stream()
                .map(u -> new Unit()
                        .setNameEN(u[1].toString())
                        .setId(Long.valueOf(u[0].toString()))
                        .setNameFA(u[1].toString()))
                .collect(Collectors.toList()));
        repository.saveAll(unitListForUpdate);
    }
}