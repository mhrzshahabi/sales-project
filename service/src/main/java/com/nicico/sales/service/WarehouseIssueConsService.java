package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseIssueConsDTO;
import com.nicico.sales.iservice.IWarehouseIssueConsService;
import com.nicico.sales.model.entities.base.WarehouseIssueCons;
import com.nicico.sales.model.entities.base.WarehouseStock;
import com.nicico.sales.repository.WarehouseIssueConsDAO;
import com.nicico.sales.repository.WarehouseStockDAO;
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
public class WarehouseIssueConsService implements IWarehouseIssueConsService {

    private final WarehouseIssueConsDAO warehouseIssueConsDAO;
    private final WarehouseStockDAO warehouseStockDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_WAREHOUSE_ISSUE_CONS')")
    public WarehouseIssueConsDTO.Info get(Long id) {
        final Optional<WarehouseIssueCons> slById = warehouseIssueConsDAO.findById(id);
        final WarehouseIssueCons warehouseIssueCons = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueConsNotFound));

        return modelMapper.map(warehouseIssueCons, WarehouseIssueConsDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_ISSUE_CONS')")
    public List<WarehouseIssueConsDTO.Info> list() {
        final List<WarehouseIssueCons> slAll = warehouseIssueConsDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseIssueConsDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_WAREHOUSE_ISSUE_CONS')")
    public WarehouseIssueConsDTO.Info create(WarehouseIssueConsDTO.Create request) {
        final WarehouseIssueCons warehouseIssueCons = modelMapper.map(request, WarehouseIssueCons.class);

        return save(warehouseIssueCons, null);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_WAREHOUSE_ISSUE_CONS')")
    public WarehouseIssueConsDTO.Info update(Long id, WarehouseIssueConsDTO.Update request) {
        final Optional<WarehouseIssueCons> slById = warehouseIssueConsDAO.findById(id);
        final WarehouseIssueCons warehouseIssueCons = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueConsNotFound));

        WarehouseIssueCons updating = new WarehouseIssueCons();
        modelMapper.map(warehouseIssueCons, updating);
        modelMapper.map(request, updating);

        return save(updating, warehouseIssueCons);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_ISSUE_CONS')")
    public void delete(Long id) {
        warehouseIssueConsDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_ISSUE_CONS')")
    public void delete(WarehouseIssueConsDTO.Delete request) {
        final List<WarehouseIssueCons> warehouseIssueConss = warehouseIssueConsDAO.findAllById(request.getIds());

        warehouseIssueConsDAO.deleteAll(warehouseIssueConss);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_ISSUE_CONS')")
    public TotalResponse<WarehouseIssueConsDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseIssueConsDAO, criteria, warehouseIssueCons -> modelMapper.map(warehouseIssueCons, WarehouseIssueConsDTO.Info.class));
    }

    private WarehouseIssueConsDTO.Info save(WarehouseIssueCons warehouseIssueCons, WarehouseIssueCons oldIssueCons) {
        Double oldAmountSarcheshmeh = (oldIssueCons != null) ? oldIssueCons.getAmountSarcheshmeh() : 0D;
        Double oldAmountMiduk = (oldIssueCons != null) ? oldIssueCons.getAmountMiduk() : 0D;
        Double oldAmountSungon = (oldIssueCons != null) ? oldIssueCons.getAmountSungon() : 0D;
        final WarehouseIssueCons saved = warehouseIssueConsDAO.saveAndFlush(warehouseIssueCons);
        oldAmountSarcheshmeh = warehouseIssueCons.getAmountSarcheshmeh() - oldAmountSarcheshmeh;
        oldAmountMiduk = warehouseIssueCons.getAmountMiduk() - oldAmountMiduk;
        oldAmountSungon = warehouseIssueCons.getAmountSungon() - oldAmountSungon;
        if (!oldAmountSarcheshmeh.equals(0D) || !oldAmountMiduk.equals(0D) || !oldAmountSungon.equals(0D)) {
            List<WarehouseStock> warehouseStockConcList = warehouseStockDAO.warehouseStockConcList();
            for (WarehouseStock w : warehouseStockConcList)
                if (!oldAmountSarcheshmeh.equals(0D) || !oldAmountMiduk.equals(0D) || !oldAmountSungon.equals(0D)) {
                    if (w.getPlant().equals("Sarcheshmeh") && !oldAmountSarcheshmeh.equals(0D)) {
                        w.setAmount(w.getAmount() - oldAmountSarcheshmeh);
                        if (w.getAmount().compareTo(0D) < 0) {
                            oldAmountSarcheshmeh = -1 * w.getAmount();
                            w.setAmount(0D);
                        } else
                            oldAmountSarcheshmeh = 0D;
                        warehouseStockDAO.saveAndFlush(w);
                    } else if (w.getPlant().equals("Miduk") && !oldAmountMiduk.equals(0D)) {
                        w.setAmount(w.getAmount() - oldAmountMiduk);
                        if (w.getAmount().compareTo(0D) < 0) {
                            oldAmountMiduk = -1 * w.getAmount();
                            w.setAmount(0D);
                        } else
                            oldAmountMiduk = 0D;
                        warehouseStockDAO.saveAndFlush(w);
                    } else if (w.getPlant().equals("sungun") && !oldAmountSungon.equals(0D)) {
                        w.setAmount(w.getAmount() - oldAmountSungon);
                        if (w.getAmount().compareTo(0D) < 0) {
                            oldAmountSungon = -1 * w.getAmount();
                            w.setAmount(0D);
                        } else
                            oldAmountSungon = 0D;
                        warehouseStockDAO.saveAndFlush(w);
                    }
                }
            if (!oldAmountSarcheshmeh.equals(0D) || !oldAmountMiduk.equals(0D) || !oldAmountSungon.equals(0D))
                throw new SalesException(SalesException.ErrorType.WarehouseStockNotFound);
        }
        return modelMapper.map(saved, WarehouseIssueConsDTO.Info.class);
    }
}
