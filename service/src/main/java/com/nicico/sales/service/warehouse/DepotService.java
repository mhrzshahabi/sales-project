package com.nicico.sales.service.warehouse;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.DepotDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.warehous.IDepotService;
import com.nicico.sales.model.entities.warehouse.Depot;
import com.nicico.sales.repository.warehouse.DepotDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
@RequiredArgsConstructor
public class DepotService implements IDepotService {
    private final DepotDAO depotDAO;
    private final ModelMapper modelMapper;

    @Override
    public DepotDTO.Info get(Long id) {
        final Optional<Depot> one = depotDAO.findById(id);
        final Depot depot = one.orElseThrow(() -> new NotFoundException());
        return modelMapper.map(depot, DepotDTO.Info.class);
    }

    @Override
    public List<DepotDTO.Info> list() {
        return modelMapper.map(depotDAO.findAll(), new TypeToken<DepotDTO.Info>() {
        }.getType());
    }

    @Override
    public TotalResponse<DepotDTO.Info> search(NICICOCriteria request) {
        final TotalResponse<DepotDTO.Info> response = SearchUtil.search(depotDAO, request, entity -> modelMapper.map(entity, DepotDTO.Info.class));
        return response;
    }

}
