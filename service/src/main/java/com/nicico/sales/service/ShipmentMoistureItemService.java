package com.nicico.sales.service;

import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentMoistureItemDTO;
import com.nicico.sales.iservice.IShipmentMoistureItemService;
import com.nicico.sales.model.entities.base.ShipmentMoistureHeader;
import com.nicico.sales.model.entities.base.ShipmentMoistureItem;
import com.nicico.sales.repository.ShipmentMoistureHeaderDAO;
import com.nicico.sales.repository.ShipmentMoistureItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentMoistureItemService implements IShipmentMoistureItemService {

    private final ShipmentMoistureItemDAO shipmentMoistureItemDAO;
    private final ShipmentMoistureHeaderDAO shipmentMoistureHeaderDAO;
    private final ModelMapper modelMapper;
    private final Gson gson;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_SHIPMENT_MOISTURE_ITEM')")
    public ShipmentMoistureItemDTO.Info get(Long id) {
        final Optional<ShipmentMoistureItem> slById = shipmentMoistureItemDAO.findById(id);
        final ShipmentMoistureItem shipmentMoistureItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentMoistureItemNotFound));

        return modelMapper.map(shipmentMoistureItem, ShipmentMoistureItemDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_SHIPMENT_MOISTURE_ITEM')")
    public List<ShipmentMoistureItemDTO.Info> list() {
        final List<ShipmentMoistureItem> slAll = shipmentMoistureItemDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ShipmentMoistureItemDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_SHIPMENT_MOISTURE_ITEM')")
    public ShipmentMoistureItemDTO.Info create(ShipmentMoistureItemDTO.Create request) {
        final ShipmentMoistureItem shipmentMoistureItem = modelMapper.map(request, ShipmentMoistureItem.class);

        return save(shipmentMoistureItem);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_SHIPMENT_MOISTURE_ITEM')")
    public ShipmentMoistureItemDTO.Info update(Long id, ShipmentMoistureItemDTO.Update request) {
        final Optional<ShipmentMoistureItem> slById = shipmentMoistureItemDAO.findById(id);
        final ShipmentMoistureItem shipmentMoistureItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentMoistureItemNotFound));

        ShipmentMoistureItem updating = new ShipmentMoistureItem();
        modelMapper.map(shipmentMoistureItem, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_SHIPMENT_MOISTURE_ITEM')")
    public void delete(Long id) {
        shipmentMoistureItemDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_SHIPMENT_MOISTURE_ITEM')")
    public void delete(ShipmentMoistureItemDTO.Delete request) {
        final List<ShipmentMoistureItem> shipmentMoistureItems = shipmentMoistureItemDAO.findAllById(request.getIds());

        shipmentMoistureItemDAO.deleteAll(shipmentMoistureItems);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_SHIPMENT_MOISTURE_ITEM')")
    public TotalResponse<ShipmentMoistureItemDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(shipmentMoistureItemDAO, criteria, shipmentMoistureItem -> modelMapper.map(shipmentMoistureItem, ShipmentMoistureItemDTO.Info.class));
    }


    private ShipmentMoistureItemDTO.Info save(ShipmentMoistureItem shipmentMoistureItem) {
        final ShipmentMoistureItem saved = shipmentMoistureItemDAO.saveAndFlush(shipmentMoistureItem);
        return modelMapper.map(saved, ShipmentMoistureItemDTO.Info.class);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_SHIPMENT_MOISTURE_ITEM')")
    public String createAddMoisturePaste(String data) {

        Map<String, Object> map = gson.fromJson(data, Map.class);

        ArrayList lotTransmitters = null;
        Long ShipmentMoistureHeaderId = new Long(map.get("ShipmentMoistureHeaderId").toString().split("[.]")[0]);
        ShipmentMoistureHeader tblShipmentMoistureHeader = shipmentMoistureHeaderDAO.findById(ShipmentMoistureHeaderId).orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));
        ;

        lotTransmitters = (ArrayList) map.get("selected");
        for (int i = 0; i < lotTransmitters.size(); i++) {
            Map itemObj = (Map) lotTransmitters.get(i);
            if (itemObj.get("lotNo") != null) {
                ShipmentMoistureItem tblShipmentMoistureItem = new ShipmentMoistureItem();
                tblShipmentMoistureItem.setShipmentMoistureHeader(tblShipmentMoistureHeader);
                tblShipmentMoistureItem.setShipmentMoistureHeaderId(tblShipmentMoistureHeader.getId());

                tblShipmentMoistureItem.setLotNo(new Long(itemObj.get("lotNo").toString().split("[.]")[0]));

                if (itemObj.get("dryWeight") != null) {
                    tblShipmentMoistureItem.setDryWeight(new Double(itemObj.get("dryWeight").toString()));
                }
                if (itemObj.get("wetWeight") != null) {
                    tblShipmentMoistureItem.setWetWeight(new Double(itemObj.get("wetWeight").toString()));
                }
                if (itemObj.get("moisturePercent") != null) {
                    tblShipmentMoistureItem.setMoisturePercent(new Double(itemObj.get("moisturePercent").toString()));
                }
                if (itemObj.get("totalH2oWeight") != null) {
                    tblShipmentMoistureItem.setTotalH2oWeight(new Double(itemObj.get("totalH2oWeight").toString()));
                }
                save(tblShipmentMoistureItem);
            }
        }
        return "ok";
    }
}
