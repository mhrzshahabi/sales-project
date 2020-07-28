package com.nicico.sales.service.contract;


import com.nicico.sales.dto.contract.ContainerToBillOfLandingDTO;
import com.nicico.sales.iservice.contract.IContainerToBillOfLandingService;
import com.nicico.sales.model.entities.contract.ContainerToBillOfLanding;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class ContainerToBillOfLandingService extends GenericService<ContainerToBillOfLanding, Long,
        ContainerToBillOfLandingDTO.Create, ContainerToBillOfLandingDTO.Info, ContainerToBillOfLandingDTO.Update, ContainerToBillOfLandingDTO.Delete> implements IContainerToBillOfLandingService {}
