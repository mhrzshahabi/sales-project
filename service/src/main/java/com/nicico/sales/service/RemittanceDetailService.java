package com.nicico.sales.service;

import com.nicico.sales.dto.InventoryDTO;
import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.iservice.IRemittanceDetailService;
import com.nicico.sales.model.entities.warehouse.Inventory;
import com.nicico.sales.model.entities.warehouse.Remittance;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.model.entities.warehouse.TozinTable;
import com.nicico.sales.repository.TozinTableDAO;
import com.nicico.sales.repository.warehouse.InventoryDAO;
import com.nicico.sales.repository.warehouse.RemittanceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class RemittanceDetailService extends GenericService<RemittanceDetail, Long, RemittanceDetailDTO.Create, RemittanceDetailDTO.Info, RemittanceDetailDTO.Update, RemittanceDetailDTO.Delete> implements IRemittanceDetailService {
    private final RemittanceDAO remittanceDAO;
    private final InventoryDAO inventoryDAO;
    private final TozinTableDAO tozinTableDAO;

    @Override
    @Transactional
    public List<RemittanceDetailDTO.Info> batchUpdate(RemittanceDetailDTO.WithRemittanceAndInventory request) {
        Remittance remittanceSaved = remittanceDAO.save(modelMapper.map(request.getRemittance(), Remittance.class));
        List<RemittanceDetail> rds = new ArrayList<>();
        final List<RemittanceDetailDTO.WithInventory> remittanceDetailsList = request.getRemittanceDetails();
        Map<String, Long> tozinKeyValue = new HashMap<>();
        remittanceDetailsList.stream().forEach(rd -> {
            final TozinTable sourceTozin = modelMapper.map(rd.getSourceTozin(), TozinTable.class);
            final TozinTable destinationTozin = modelMapper.map(rd.getDestinationTozin(), TozinTable.class);
            if (!tozinKeyValue.containsKey(sourceTozin.getTozinId())) {
                tozinKeyValue.put(sourceTozin.getTozinId(), tozinTableDAO.save(sourceTozin).getId());
            }
            if (!tozinKeyValue.containsKey(destinationTozin.getTozinId())) {
                tozinKeyValue.put(destinationTozin.getTozinId(), tozinTableDAO.save(destinationTozin).getId());
            }

        });
        remittanceDetailsList.stream().forEach(rd -> {
            final InventoryDTO.Create inventory = rd.getInventory();
            final Inventory inventorySaved = inventoryDAO.save(modelMapper.map(inventory, Inventory.class));
            final RemittanceDetail remittanceDetail = modelMapper.map(rd, RemittanceDetail.class);
            remittanceDetail.setRemittanceId(remittanceSaved.getId());
            remittanceDetail.setInventoryId(inventorySaved.getId());
            remittanceDetail.setSourceTozinId(tozinKeyValue.get(rd.getSourceTozin().getTozinId()));
            remittanceDetail.setDestinationTozinId(tozinKeyValue.get(rd.getDestinationTozin().getTozinId()));
            rds.add(remittanceDetail);
        });
        final List<RemittanceDetail> remittanceDetails = repository.saveAll(rds);
        return modelMapper.map(remittanceDetails, new TypeToken<List<RemittanceDetailDTO.Info>>() {
        }.getType());
    }
}
