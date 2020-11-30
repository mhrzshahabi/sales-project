package com.nicico.sales.iservice.contract;


import com.nicico.sales.dto.contract.BillOfLadingSwitchDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.BillOfLadingSwitch;

public interface IBillOfLadingSwitchService extends IGenericService<BillOfLadingSwitch, Long, BillOfLadingSwitchDTO.Create, BillOfLadingSwitchDTO.Info, BillOfLadingSwitchDTO.Update, BillOfLadingSwitchDTO.Delete> {
}
