package com.nicico.sales.service;

import com.nicico.sales.dto.InventoryDTO;
import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.iservice.IRemittanceDetailService;
import com.nicico.sales.model.entities.base.Tozin;
import com.nicico.sales.model.entities.warehouse.Inventory;
import com.nicico.sales.model.entities.warehouse.Remittance;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.model.entities.warehouse.TozinTable;
import com.nicico.sales.repository.TozinDAO;
import com.nicico.sales.repository.TozinTableDAO;
import com.nicico.sales.repository.warehouse.InventoryDAO;
import com.nicico.sales.repository.warehouse.RemittanceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@RequiredArgsConstructor
@Service
public class RemittanceDetailService extends GenericService<RemittanceDetail, Long, RemittanceDetailDTO.Create, RemittanceDetailDTO.Info, RemittanceDetailDTO.Update, RemittanceDetailDTO.Delete> implements IRemittanceDetailService {
    private final RemittanceDAO remittanceDAO;
    private final InventoryDAO inventoryDAO;
    private final TozinTableDAO tozinTableDAO;
    private final TozinDAO tozinDAO;

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
            saveTozin(tozinKeyValue, sourceTozin);
            saveTozin(tozinKeyValue, destinationTozin);
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

    @Override
    @Transactional
    public List<RemittanceDetailDTO.Info> out(RemittanceDetailDTO.OutRemittance request) {
        final Long remittanceId = remittanceDAO.save(modelMapper.map(request.getRemittance(), Remittance.class)).getId();
        List<RemittanceDetail> details = new ArrayList<>();
        Map<String, TozinTable> tozinTableSet = new HashMap();
        request.getRemittanceDetails().stream().forEach(rd -> {
            final String tozinId = rd.getSourceTozin().getTozinId();
            if (!tozinTableSet.containsKey(tozinId))
                tozinTableSet.put(tozinId, tozinTableDAO.saveAndFlush(modelMapper.map(rd.getSourceTozin(), TozinTable.class)));
        });
        request
                .getRemittanceDetails()
                .parallelStream()
                .forEach(r -> {
                    final RemittanceDetail remittanceDetail = modelMapper.map(r, RemittanceDetail.class);
                    remittanceDetail.setSourceTozinId(tozinTableSet.get(r.getSourceTozin().getTozinId()).getId());
                    remittanceDetail.setRemittanceId(remittanceId);
                    details.add(remittanceDetail);
                });

        final List<RemittanceDetail> remittanceDetailList = repository.saveAll(details);
        final List<RemittanceDetailDTO.Info> infoList = modelMapper.map(remittanceDetailList, new TypeToken<List<RemittanceDetailDTO.Info>>() {
        }.getType());
        return infoList;
    }

    private void saveTozin(Map<String, Long> tozinKeyValue, TozinTable tozinTable) {
        if (!tozinKeyValue.containsKey(tozinTable.getTozinId())) {
            final Tozin tozin = tozinDAO.findFirstByTozinId(tozinTable.getTozinId());
            if (tozin != null) {
                final TozinTable tozinToSave = modelMapper.map(tozin, TozinTable.class);
                tozinToSave.setDriverName(tozinTable.getDriverName());
                tozinKeyValue.put(tozinTable.getTozinId(), tozinTableDAO.save(tozinToSave).getId());
            } else tozinKeyValue.put(tozinTable.getTozinId(), tozinTableDAO.save(tozinTable).getId());
        }
    }
}
