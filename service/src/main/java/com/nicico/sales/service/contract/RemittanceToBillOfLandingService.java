package com.nicico.sales.service.contract;


import com.nicico.sales.dto.contract.RemittanceToBillOfLandingDTO;
import com.nicico.sales.iservice.contract.IRemittanceToBillOfLandingService;
import com.nicico.sales.model.entities.contract.RemittanceToBillOfLanding;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class RemittanceToBillOfLandingService extends GenericService<RemittanceToBillOfLanding, Long,
        RemittanceToBillOfLandingDTO.Create, RemittanceToBillOfLandingDTO.Info, RemittanceToBillOfLandingDTO.Update, RemittanceToBillOfLandingDTO.Delete> implements IRemittanceToBillOfLandingService {

}
