package com.nicico.sales.service.contract;


import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.RemittanceToBillOfLandingDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IRemittanceToBillOfLandingService;
import com.nicico.sales.model.entities.contract.RemittanceToBillOfLanding;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class RemittanceToBillOfLandingService extends GenericService<RemittanceToBillOfLanding, Long,
        RemittanceToBillOfLandingDTO.Create, RemittanceToBillOfLandingDTO.Info, RemittanceToBillOfLandingDTO.Update,
        RemittanceToBillOfLandingDTO.Delete> implements IRemittanceToBillOfLandingService {

    @Action(value = ActionType.Create)
    @Transactional
    @Override
    public List<RemittanceToBillOfLandingDTO.Info> batch(List<RemittanceToBillOfLandingDTO.Create> request) {
        final List<RemittanceToBillOfLanding> requests = modelMapper.map(request,
                new TypeToken<List<RemittanceToBillOfLanding>>() {
        }.getType());
        final List<RemittanceToBillOfLanding> saved = repository.saveAll(requests);
        return modelMapper.map(saved,new TypeToken<List<RemittanceToBillOfLandingDTO.Info>>(){}.getType());
    }
}
