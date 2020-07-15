package com.nicico.sales.service;

import com.nicico.sales.dto.RemittanceDTO;
import com.nicico.sales.iservice.IRemittanceService;
import com.nicico.sales.model.entities.warehouse.Remittance;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.repository.TozinTableDAO;
import com.nicico.sales.repository.warehouse.InventoryDAO;
import com.nicico.sales.repository.warehouse.RemittanceDetailDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class RemittanceService extends GenericService<Remittance, Long, RemittanceDTO.Create, RemittanceDTO.Info, RemittanceDTO.Update, RemittanceDTO.Delete> implements IRemittanceService {
    private final RemittanceDetailDAO remittanceDetailDAO;
    private final InventoryDAO inventoryDAO;
    private final TozinTableDAO tozinTableDAO;

    @Override
    @Transactional
    public void deleteAll(RemittanceDTO.Delete request) {
        final List<Remittance> allRemittanceById = repository.findAllById(request.getIds());
        final List<RemittanceDetail> allByRemittanceIdIsIn = remittanceDetailDAO.findAllByRemittanceIdIsIn(request.getIds());
        Set<Long> inventoryIdList = new HashSet<>();
        Set<Long> tozinIdList = new HashSet<>();
        allByRemittanceIdIsIn.stream().forEach(rd -> {
            inventoryIdList.add(rd.getInventoryId());
            tozinIdList.add(rd.getDestinationTozinId());
            tozinIdList.add(rd.getSourceTozinId());
        });
        remittanceDetailDAO.deleteAllByIdIn(allByRemittanceIdIsIn.stream().map(rd -> rd.getId()).collect(Collectors.toList()));
        inventoryDAO.deleteAllByIdIn(inventoryIdList);
        tozinTableDAO.deleteAllByIdIn(tozinIdList);
        super.deleteAll(request);
    }
}
