package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.contract.IContractDetailService;
import com.nicico.sales.model.entities.contract.ContractDetail;
import com.nicico.sales.repository.contract.ContractDetailDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.PropertyMap;
import org.modelmapper.TypeMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ContractDetailService extends GenericService<ContractDetail, Long, ContractDetailDTO.Create, ContractDetailDTO.Info, ContractDetailDTO.Update, ContractDetailDTO.Delete> implements IContractDetailService {

    @Override
    @Transactional
    @Action(ActionType.Get)
    public ContractDetailDTO.Info getContractDetailByContractDetailTypeCode(Long contractId,Long materialId, EContractDetailTypeCode typeCode) {

        final Optional<ContractDetail> entityById = ((ContractDetailDAO) repository).findByContractDetailType(contractId,materialId,typeCode.getId());
        final ContractDetail entity = entityById.orElseThrow(() -> new NotFoundException(ContractDetail.class));

        ContractDetailDTO.Info result = modelMapper.map(entity, ContractDetailDTO.Info.class);
        validation(entity, result);

        return result;
    }


    @Override
    @Action(value = ActionType.Update)
    @Transactional
    public ContractDetailDTO.Info update(Long id, ContractDetailDTO.Update request) {

        final Optional<ContractDetail> entityById = repository.findById(id);
        final ContractDetail entity = entityById.orElseThrow(() -> new NotFoundException(ContractDetail.class));

        ContractDetail updating = new ContractDetail();

        TypeMap<ContractDetail, ContractDetail> typeMap = modelMapper.getTypeMap(ContractDetail.class, ContractDetail.class);
        if (typeMap == null) { // if not  already added
            modelMapper.addMappings(new PropertyMap<ContractDetail, ContractDetail>() {
                @Override
                protected void configure() {
                    skip(destination.getContractDetailValues());
                }
            });
        }

        modelMapper.map(entity, updating);
        modelMapper.map(request, updating);

        validation(updating, request);
        return modelMapper.map(repository.save(updating), ContractDetailDTO.Info.class);
    }
}
