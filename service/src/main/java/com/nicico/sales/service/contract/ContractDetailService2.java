package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractDetailDTO2;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.contract.IContractDetailService2;
import com.nicico.sales.model.entities.contract.ContractDetail2;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.PropertyMap;
import org.modelmapper.TypeMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ContractDetailService2 extends GenericService<ContractDetail2, Long, ContractDetailDTO2.Create, ContractDetailDTO2.Info, ContractDetailDTO2.Update, ContractDetailDTO2.Delete> implements IContractDetailService2 {
    @Override
    @Action(value = ActionType.Update)
    @Transactional
    public ContractDetailDTO2.Info update(Long id, ContractDetailDTO2.Update request) {

        final Optional<ContractDetail2> entityById = repository.findById(id);
        final ContractDetail2 entity = entityById.orElseThrow(() -> new NotFoundException(ContractDetail2.class));

        ContractDetail2 updating = new ContractDetail2();

        TypeMap<ContractDetail2, ContractDetail2> typeMap = modelMapper.getTypeMap(ContractDetail2.class, ContractDetail2.class);
        if (typeMap == null) { // if not  already added
            modelMapper.addMappings(new PropertyMap<ContractDetail2, ContractDetail2>() {
                @Override
                protected void configure() {
                    skip(destination.getContractDetailValues());
                }
            });
        }

        modelMapper.map(entity, updating);
        modelMapper.map(request, updating);

        validation(updating, request);
        return modelMapper.map(repository.save(entity), ContractDetailDTO2.Info.class);
    }
}
