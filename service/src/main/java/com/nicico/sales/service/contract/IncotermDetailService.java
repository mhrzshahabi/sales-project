package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.IncotermDetailDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.contract.IIncotermDetailService;
import com.nicico.sales.model.entities.contract.IncotermDetail;
import com.nicico.sales.model.entities.contract.IncotermParties;
import com.nicico.sales.repository.contract.IncotermPartiesDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class IncotermDetailService extends GenericService<IncotermDetail, Long, IncotermDetailDTO.Create, IncotermDetailDTO.Info, IncotermDetailDTO.Update, IncotermDetailDTO.Delete> implements IIncotermDetailService {

    private final IncotermPartiesDAO incotermPartiesDAO;

    @Override
    @Transactional
    @Action(value = ActionType.Create, authority = "" +
            "hasAuthority('C_INCOTERM_DETAIL') AND " +
            "hasAuthority('C_INCOTERM_PARTIES')")
    public IncotermDetailDTO.Info create(IncotermDetailDTO.Create request) {

        IncotermDetailDTO.Info incotermDetail = super.create(request);

        List<IncotermParties> incotermPartiesCreateList = new ArrayList<>();
        request.getIncotermParties().forEach(item -> {
            IncotermParties incotermParties = new IncotermParties();
            incotermParties.setPortion(item.getPortion()).
                    setIncotermPartyId(item.getIncotermPartyId()).
                    setIncotermDetailId(incotermDetail.getId());
            incotermPartiesCreateList.add(incotermParties);
        });
        incotermPartiesDAO.saveAll(incotermPartiesCreateList);

        return incotermDetail;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Create, authority = "" +
            "hasAuthority('C_INCOTERM_DETAIL') AND " +
            "hasAuthority('C_INCOTERM_PARTIES')")
    public List<IncotermDetailDTO.Info> createAll(List<IncotermDetailDTO.Create> requests) {

        return requests.stream().map(this::create).collect(Collectors.toList());
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update, authority = "" +
            "hasAuthority('U_INCOTERM_DETAIL') AND " +
            "hasAuthority('U_INCOTERM_PARTIES')")
    public IncotermDetailDTO.Info update(Long id, IncotermDetailDTO.Update request) {

        final Optional<IncotermDetail> entity = repository.findById(id);
        final IncotermDetail incotermDetail = entity.orElseThrow(() -> new NotFoundException(IncotermDetail.class));

        incotermPartiesDAO.deleteAllByIncotermDetailId(id);
        List<IncotermParties> incotermPartiesCreateList = new ArrayList<>();
        request.getIncotermParties().forEach(item -> {
            IncotermParties incotermParties = new IncotermParties();
            incotermParties.setPortion(item.getPortion()).
                    setIncotermPartyId(item.getIncotermPartyId()).
                    setIncotermDetailId(id);
            incotermPartiesCreateList.add(incotermParties);
        });
        List<IncotermParties> savedIncotermParties = incotermPartiesDAO.saveAll(incotermPartiesCreateList);

        IncotermDetail updating = new IncotermDetail();
        modelMapper.map(incotermDetail, updating);
        modelMapper.map(request, updating);
        updating.setIncotermParties(savedIncotermParties);

        validation(updating, request);
        return save(updating);
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update, authority = "" +
            "hasAuthority('U_INCOTERM_DETAIL') AND " +
            "hasAuthority('U_INCOTERM_PARTIES')")
    public List<IncotermDetailDTO.Info> updateAll(List<Long> ids, List<IncotermDetailDTO.Update> requests) {

        return requests.stream().map(request -> update(request.getId(), request)).collect(Collectors.toList());
    }
}
