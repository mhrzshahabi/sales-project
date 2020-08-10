package com.nicico.sales.service.contract;


import com.nicico.sales.dto.contract.BillOfLandingDTO;
import com.nicico.sales.iservice.contract.IBillOfLandingService;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class BillOfLandingService extends GenericService<BillOfLanding, Long,
        BillOfLandingDTO.Create, BillOfLandingDTO.Info, BillOfLandingDTO.Update, BillOfLandingDTO.Delete> implements IBillOfLandingService {}
