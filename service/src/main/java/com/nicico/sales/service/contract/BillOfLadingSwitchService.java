package com.nicico.sales.service.contract;


import com.nicico.sales.dto.contract.BillOfLadingSwitchDTO;
import com.nicico.sales.iservice.contract.IBillOfLadingSwitchService;
import com.nicico.sales.model.entities.contract.BillOfLadingSwitch;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class BillOfLadingSwitchService extends GenericService<BillOfLadingSwitch, Long,
        BillOfLadingSwitchDTO.Create, BillOfLadingSwitchDTO.Info, BillOfLadingSwitchDTO.Update, BillOfLadingSwitchDTO.Delete> implements IBillOfLadingSwitchService {
    
}