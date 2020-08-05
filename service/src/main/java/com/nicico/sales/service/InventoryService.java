package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InventoryDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IinventoryService;
import com.nicico.sales.model.entities.warehouse.Inventory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class InventoryService extends GenericService<Inventory, Long, InventoryDTO.Create, InventoryDTO.Info, InventoryDTO.Update, InventoryDTO.Delete> implements IinventoryService {
    @Override
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public TotalResponse<InventoryDTO.Info> getAllInventoriesByWarehouse(NICICOCriteria request) {

        List<Inventory> entities = new ArrayList<>();
        TotalResponse<InventoryDTO.Info> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            InventoryDTO.Info eResult = modelMapper.map(entity, InventoryDTO.Info.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);


        return result;
    }
}
