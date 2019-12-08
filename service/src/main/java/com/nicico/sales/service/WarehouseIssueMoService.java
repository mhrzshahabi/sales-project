package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseIssueMoDTO;
import com.nicico.sales.iservice.IWarehouseCadItemService;
import com.nicico.sales.iservice.IWarehouseIssueMoService;
import com.nicico.sales.model.entities.base.WarehouseCadItem;
import com.nicico.sales.model.entities.base.WarehouseIssueMo;
import com.nicico.sales.model.entities.base.WarehouseLot;
import com.nicico.sales.repository.WarehouseCadItemDAO;
import com.nicico.sales.repository.WarehouseIssueMoDAO;
import com.nicico.sales.repository.WarehouseLotDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseIssueMoService implements IWarehouseIssueMoService {

	private final WarehouseIssueMoDAO warehouseIssueMoDAO;
	private final WarehouseCadItemDAO warehouseCadItemDAO;
	private final WarehouseLotDAO 	  warehouseLotDAO;
	private final IWarehouseCadItemService warehouseCadItemService;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
	public WarehouseIssueMoDTO.Info get(Long id) {
		final Optional<WarehouseIssueMo> slById = warehouseIssueMoDAO.findById(id);
		final WarehouseIssueMo warehouseIssueMo = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueMoNotFound));

		return modelMapper.map(warehouseIssueMo, WarehouseIssueMoDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
	public List<WarehouseIssueMoDTO.Info> list() {
		final List<WarehouseIssueMo> slAll = warehouseIssueMoDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<WarehouseIssueMoDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('C_WAREHOUSEISSUEMO')")
	public WarehouseIssueMoDTO.Info create(WarehouseIssueMoDTO.Create request) {
		final WarehouseIssueMo warehouseIssueMo = modelMapper.map(request, WarehouseIssueMo.class);

		return save(warehouseIssueMo, null);
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('U_WAREHOUSEISSUEMO')")
	public WarehouseIssueMoDTO.Info update(Long id, WarehouseIssueMoDTO.Update request) {
		final Optional<WarehouseIssueMo> slById = warehouseIssueMoDAO.findById(id);
		final WarehouseIssueMo warehouseIssueMo = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueMoNotFound));

		WarehouseIssueMo updating = new WarehouseIssueMo();
		modelMapper.map(warehouseIssueMo, updating);
		modelMapper.map(request, updating);

		return save(updating, warehouseIssueMo);
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUEMO')")
	public void delete(Long id) {
		final WarehouseIssueMo mo= warehouseIssueMoDAO.findById(id).orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueMoNotFound));
		if (mo.getWarehouseLot().getWarehouseCadItem()!=null && mo.getWarehouseLot().getWarehouseCadItem().getIssueId()!=null ){ // kasr as anbar
			final WarehouseCadItem bijak = warehouseCadItemDAO.findById( mo.getWarehouseLot().getWarehouseCadItemId())
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));
			warehouseCadItemService.saveIssue(bijak, null);
		}
		warehouseIssueMoDAO.deleteById(id);
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUEMO')")
	public void delete(WarehouseIssueMoDTO.Delete request) {
		final List<WarehouseIssueMo> warehouseIssueMos = warehouseIssueMoDAO.findAllById(request.getIds());

		warehouseIssueMoDAO.deleteAll(warehouseIssueMos);
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
	public TotalResponse<WarehouseIssueMoDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(warehouseIssueMoDAO, criteria, warehouseIssueMo -> modelMapper.map(warehouseIssueMo, WarehouseIssueMoDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
	public SearchDTO.SearchRs<WarehouseIssueMoDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(warehouseIssueMoDAO, request, entity -> modelMapper.map(entity, WarehouseIssueMoDTO.Info.class));
	}

	private WarehouseIssueMoDTO.Info save(WarehouseIssueMo warehouseIssueMo, WarehouseIssueMo oldIssueMo) {
		Long oldIssue=0L;
		if (oldIssueMo!=null)
		    oldIssue=oldIssueMo.getWarehouseLot().getWarehouseCadItemId();
		final WarehouseLot lot= warehouseLotDAO.findById(warehouseIssueMo.getWarehouseLotId()).orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseLotNotFound));
//		WarehouseCadItem bijak =lot.getWarehouseCadItem();
		WarehouseCadItem bijak = warehouseCadItemDAO.findById(lot.getWarehouseCadItemId())
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));
		final WarehouseIssueMo saved = warehouseIssueMoDAO.saveAndFlush(warehouseIssueMo);

		warehouseCadItemService.saveIssue(bijak, saved.getId()); // add be anbar

		if (!oldIssue.equals(0L) && !oldIssue.equals(bijak.getId())){ // kasr as anbar
			bijak = warehouseCadItemDAO.findById(oldIssue)
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));
			warehouseCadItemService.saveIssue(bijak, null);
		}

		return modelMapper.map(saved, WarehouseIssueMoDTO.Info.class);
	}
}
