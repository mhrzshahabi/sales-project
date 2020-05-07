package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IContractDetailTypeService;
import com.nicico.sales.model.entities.contract.ContractDetailType;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeService extends GenericService<ContractDetailType, Long, ContractDetailTypeDTO.Create, ContractDetailTypeDTO.Info, ContractDetailTypeDTO.Update, ContractDetailTypeDTO.Delete> implements IContractDetailTypeService {

    @Override
    @Transactional
    @Action(value = ActionType.Create, authority =
            "hasAuthority('C_CONTRACT_DETAIL_TYPE') AND " +
                    "hasAuthority('C_CONTRACT_DETAIL_TYPE_PARAM') AND " +
                    "hasAuthority('C_CONTRACT_DETAIL_TYPE_PARAM_VALUE AND " +
                    "hasAuthority('C_CONTRACT_DETAIL_TYPE_TEMPLATE')")
    public ContractDetailTypeDTO.Info create(ContractDetailTypeDTO.Create request) {
        return super.create(request);
    }

    @Override
    public ContractDetailTypeDTO.Info update(Long aLong, ContractDetailTypeDTO.Update request) {


        throw new RuntimeException();
    }
}