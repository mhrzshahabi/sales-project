package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.MaterialItemDTO;
import com.nicico.sales.iservice.IMaterialItemService;
import com.nicico.sales.model.entities.base.MaterialItem;
import com.nicico.sales.repository.MaterialItemDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class MaterialItemService extends GenericService<MaterialItem, Long, MaterialItemDTO.Create, MaterialItemDTO.Info, MaterialItemDTO.Update, MaterialItemDTO.Delete> implements IMaterialItemService {


    @Override
    public void updateFromTozinView() {
        List<Object[]> allItemsFromViewForUpdate = ((MaterialItemDAO) repository).itemsForUpdate();
        Map<Long, String> ItemsFetchedForUpdate = new HashMap<>();
        allItemsFromViewForUpdate.stream()
                .forEach((Object[] u) -> ItemsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<MaterialItem> materialItems = new ArrayList<>();
        materialItems.addAll(repository.findAllById(ItemsFetchedForUpdate.keySet()));
        materialItems.stream()
                .forEach(u -> u.setGdsName(ItemsFetchedForUpdate.get(u.getId()))
                        .setGdsCode(u.getId())
                );
        List<Object[]> allItemsFromViewForInsert = ((MaterialItemDAO) repository).itemsForInsert();
        materialItems.addAll(allItemsFromViewForInsert
                .stream()
                .map(u -> new MaterialItem()
                        .setId(Long.valueOf(u[0].toString()))
                        .setGdsCode(Long.valueOf(u[0].toString()))
                        .setGdsName(u[1].toString())
                        .setMaterialId(Long.valueOf(u[0].toString().contains("کاتد") ? 2L : (Long.valueOf(u[0].toString().contains("مولیبدن") ? 1L : 3L))))
                ).collect(Collectors.toList()));
        repository.saveAll(materialItems);
    }


    @Override
    public TotalResponse<MaterialItemDTO.InfoWithInventories> searchWithInventories(NICICOCriteria request){
        List<MaterialItem> entities = new ArrayList<>();
        final TotalResponse<MaterialItemDTO.InfoWithInventories> totalResponse = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            MaterialItemDTO.InfoWithInventories eResult = modelMapper.map(entity, MaterialItemDTO.InfoWithInventories.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });
        validationAll(entities, totalResponse);
        return totalResponse;
    }

}
