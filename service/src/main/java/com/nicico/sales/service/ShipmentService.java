package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.annotation.CheckCriteria;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.repository.ShipmentDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class ShipmentService extends GenericService<Shipment, Long, ShipmentDTO.Create, ShipmentDTO.Info, ShipmentDTO.Update, ShipmentDTO.Delete> implements IShipmentService {

    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.List)
    public List<Object[]> pickListShipment() {
        return ((ShipmentDAO) repository).pickListShipment();
    }


    @Override
    @CheckCriteria
    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public TotalResponse<ShipmentDTO.ShipmentLightFIInfo> foreignSearch(NICICOCriteria request) {

        List<Shipment> entities = new ArrayList<>();
        TotalResponse<ShipmentDTO.ShipmentLightFIInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ShipmentDTO.ShipmentLightFIInfo eResult = modelMapper.map(entity, ShipmentDTO.ShipmentLightFIInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    public SearchDTO.SearchRs<ShipmentDTO.ShipmentLightFIInfo> foreignSearch(SearchDTO.SearchRq request) {

        List<Shipment> entities = new ArrayList<>();
        SearchDTO.SearchRs<ShipmentDTO.ShipmentLightFIInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ShipmentDTO.ShipmentLightFIInfo eResult = modelMapper.map(entity, ShipmentDTO.ShipmentLightFIInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public SearchDTO.SearchRs<ShipmentDTO.ReportInfo> reportSearch(SearchDTO.SearchRq request) {

        List<Shipment> entities = new ArrayList<>();
        SearchDTO.SearchRs<ShipmentDTO.ReportInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ShipmentDTO.ReportInfo eResult = modelMapper.map(entity, ShipmentDTO.ReportInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @CheckCriteria
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public TotalResponse<ShipmentDTO.ReportInfo> reportSearch(NICICOCriteria request) {

        List<Shipment> entities = new ArrayList<>();
        TotalResponse<ShipmentDTO.ReportInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ShipmentDTO.ReportInfo eResult = modelMapper.map(entity, ShipmentDTO.ReportInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }
}
