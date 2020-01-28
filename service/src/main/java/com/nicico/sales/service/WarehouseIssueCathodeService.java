package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseIssueCathodeDTO;
import com.nicico.sales.iservice.IWarehouseIssueCathodeService;
import com.nicico.sales.model.entities.base.WarehouseCadItem;
import com.nicico.sales.model.entities.base.WarehouseIssueCathode;
import com.nicico.sales.repository.WarehouseCadItemDAO;
import com.nicico.sales.repository.WarehouseIssueCathodeDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseIssueCathodeService implements IWarehouseIssueCathodeService {

    private final WarehouseIssueCathodeDAO warehouseIssueCathodeDAO;
    private final WarehouseCadItemDAO warehouseCadItemDAO;
    private final WarehouseCadItemService warehouseCadItemService;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_WAREHOUSE_ISSUE_CATHODE')")
    public WarehouseIssueCathodeDTO.Info get(Long id) {
        final Optional<WarehouseIssueCathode> slById = warehouseIssueCathodeDAO.findById(id);
        final WarehouseIssueCathode warehouseIssueCathode = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueCathodeNotFound));

        return modelMapper.map(warehouseIssueCathode, WarehouseIssueCathodeDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_ISSUE_CATHODE')")
    public List<WarehouseIssueCathodeDTO.Info> list() {
        final List<WarehouseIssueCathode> slAll = warehouseIssueCathodeDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseIssueCathodeDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_WAREHOUSE_ISSUE_CATHODE')")
    public WarehouseIssueCathodeDTO.Info create(WarehouseIssueCathodeDTO.Create request) {
        final WarehouseIssueCathode warehouseIssueCathode = modelMapper.map(request, WarehouseIssueCathode.class);

        return save(warehouseIssueCathode, null);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_WAREHOUSE_ISSUE_CATHODE')")
    public WarehouseIssueCathodeDTO.Info update(Long id, WarehouseIssueCathodeDTO.Update request) {
        final Optional<WarehouseIssueCathode> slById = warehouseIssueCathodeDAO.findById(id);
        final WarehouseIssueCathode warehouseIssueCathode = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueCathodeNotFound));

        WarehouseIssueCathode updating = new WarehouseIssueCathode();
        modelMapper.map(warehouseIssueCathode, updating);
        modelMapper.map(request, updating);

        return save(updating, warehouseIssueCathode);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_ISSUE_CATHODE')")
    public void delete(Long id) {
        WarehouseIssueCathode warehouseIssueCathode = warehouseIssueCathodeDAO.findById(id)
                .orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueCathodeNotFound));
        String oldIds[] = warehouseIssueCathode.getBijakIds().split(",");
        for (int o = 0; o < oldIds.length; o++) {
            Long idL = new Long(oldIds[o]);
            WarehouseCadItem bijak = warehouseCadItemDAO.findById(idL)
                    .orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));
            warehouseCadItemService.saveIssue(bijak, null);
        }
        warehouseIssueCathodeDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_ISSUE_CATHODE')")
    public void delete(WarehouseIssueCathodeDTO.Delete request) {
        final List<WarehouseIssueCathode> warehouseIssueCathodes = warehouseIssueCathodeDAO.findAllById(request.getIds());

        warehouseIssueCathodeDAO.deleteAll(warehouseIssueCathodes);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_ISSUE_CATHODE')")
    public TotalResponse<WarehouseIssueCathodeDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseIssueCathodeDAO, criteria, warehouseIssueCathode -> modelMapper.map(warehouseIssueCathode, WarehouseIssueCathodeDTO.Info.class));
    }

    private WarehouseIssueCathodeDTO.Info save(WarehouseIssueCathode warehouseIssueCathode, WarehouseIssueCathode oldIssueCathode) {
        String newIds[] = warehouseIssueCathode.getBijakIds().split(",");
        String oldIds[] = {"x"};
        if (oldIssueCathode != null && oldIssueCathode.getBijakIds() != null)
            oldIds = oldIssueCathode.getBijakIds().split(",");

        final WarehouseIssueCathode saved = warehouseIssueCathodeDAO.saveAndFlush(warehouseIssueCathode);
        for (int n = 0; n < newIds.length; n++)
            for (int o = 0; o < oldIds.length; o++)
                if (newIds[n].equals(oldIds[o])) {
                    newIds[n] = "x";
                    oldIds[o] = "x";
                }
        for (int n = 0; n < newIds.length; n++)
            if (!newIds[n].equals("x")) {
                Long idL = new Long(newIds[n]);
                WarehouseCadItem bijak = warehouseCadItemDAO.findById(idL)
                        .orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));
                warehouseCadItemService.saveIssue(bijak, saved.getId());

            }
        for (int o = 0; o < oldIds.length; o++)
            if (!oldIds[o].equals("x")) {
                Long idL = new Long(oldIds[o]);
                WarehouseCadItem bijak = warehouseCadItemDAO.findById(idL)
                        .orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));
                warehouseCadItemService.saveIssue(bijak, null);

            }
        return modelMapper.map(saved, WarehouseIssueCathodeDTO.Info.class);
    }
}
