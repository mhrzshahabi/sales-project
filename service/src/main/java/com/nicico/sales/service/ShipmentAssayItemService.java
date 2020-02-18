package com.nicico.sales.service;

import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentAssayItemDTO;
import com.nicico.sales.iservice.IShipmentAssayItemService;
import com.nicico.sales.model.entities.base.ShipmentAssayHeader;
import com.nicico.sales.model.entities.base.ShipmentAssayItem;
import com.nicico.sales.repository.ShipmentAssayHeaderDAO;
import com.nicico.sales.repository.ShipmentAssayItemDAO;
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
public class ShipmentAssayItemService implements IShipmentAssayItemService {

    private final ShipmentAssayHeaderDAO shipmentAssayHeaderDAO;
    private final ShipmentAssayItemDAO shipmentAssayItemDAO;
    private final ModelMapper modelMapper;
    private final Gson gson;


    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_SHIPMENT_ASSAY_ITEM')")
    public ShipmentAssayItemDTO.Info get(Long id) {
        final Optional<ShipmentAssayItem> slById = shipmentAssayItemDAO.findById(id);
        final ShipmentAssayItem shipmentAssayItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentAssayItemNotFound));

        return modelMapper.map(shipmentAssayItem, ShipmentAssayItemDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_SHIPMENT_ASSAY_ITEM')")
    public List<ShipmentAssayItemDTO.Info> list() {
        final List<ShipmentAssayItem> slAll = shipmentAssayItemDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ShipmentAssayItemDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_SHIPMENT_ASSAY_ITEM')")
    public ShipmentAssayItemDTO.Info create(ShipmentAssayItemDTO.Create request) {
        final ShipmentAssayItem shipmentAssayItem = modelMapper.map(request, ShipmentAssayItem.class);

        return save(shipmentAssayItem);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_SHIPMENT_ASSAY_ITEM')")
    public ShipmentAssayItemDTO.Info update(Long id, ShipmentAssayItemDTO.Update request) {
        final Optional<ShipmentAssayItem> slById = shipmentAssayItemDAO.findById(id);
        final ShipmentAssayItem shipmentAssayItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentAssayItemNotFound));

        ShipmentAssayItem updating = new ShipmentAssayItem();
        modelMapper.map(shipmentAssayItem, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_SHIPMENT_ASSAY_ITEM')")
    public void delete(Long id) {
        shipmentAssayItemDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_SHIPMENT_ASSAY_ITEM')")
    public void delete(ShipmentAssayItemDTO.Delete request) {
        final List<ShipmentAssayItem> shipmentAssayItems = shipmentAssayItemDAO.findAllById(request.getIds());

        shipmentAssayItemDAO.deleteAll(shipmentAssayItems);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_SHIPMENT_ASSAY_ITEM')")
    public TotalResponse<ShipmentAssayItemDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(shipmentAssayItemDAO, criteria, instruction -> modelMapper.map(instruction, ShipmentAssayItemDTO.Info.class));
    }


    private ShipmentAssayItemDTO.Info save(ShipmentAssayItem shipmentAssayItem) {
        final ShipmentAssayItem saved = shipmentAssayItemDAO.saveAndFlush(shipmentAssayItem);
        return modelMapper.map(saved, ShipmentAssayItemDTO.Info.class);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_SHIPMENT_ASSAY_ITEM')")
    public String createAddAssayPaste(String data) {
        Map<String, Object> map = gson.fromJson(data, Map.class);

        ArrayList lotTransmitters = null;
        Long ShipmentAssayHeaderId = new Long(map.get("ShipmentAssayHeaderId").toString().split("[.]")[0]);
        ShipmentAssayHeader tblShipmentAssayHeader = shipmentAssayHeaderDAO.findById(ShipmentAssayHeaderId).orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));
        lotTransmitters = (ArrayList) map.get("selected");
        for (int i = 0; i < lotTransmitters.size(); i++) {
            Map itemObj = (Map) lotTransmitters.get(i);
            if (itemObj.get("lotNo") != null) {
                ShipmentAssayItem tblShipmentAssayItem = new ShipmentAssayItem();
                tblShipmentAssayItem.setShipmentAssayHeaderId(tblShipmentAssayHeader.getId());
                tblShipmentAssayItem.setLotNo(new Long(itemObj.get("lotNo").toString().split("[.]")[0]));

                if (itemObj.get("ag") != null) {
                    tblShipmentAssayItem.setAg(new Double(itemObj.get("ag").toString()));
                }
                if (itemObj.get("au") != null) {
                    tblShipmentAssayItem.setAu(new Double(itemObj.get("au").toString()));
                }
                if (itemObj.get("cu") != null) {
                    tblShipmentAssayItem.setCu(new Double(itemObj.get("cu").toString()));
                }
                save(tblShipmentAssayItem);
            }
        }
        return "ok";
    }
}
