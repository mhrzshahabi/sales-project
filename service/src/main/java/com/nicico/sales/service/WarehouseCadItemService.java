package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseCadItemDTO;
import com.nicico.sales.iservice.IWarehouseCadItemService;
import com.nicico.sales.model.entities.base.WarehouseCad;
import com.nicico.sales.model.entities.base.WarehouseCadItem;
import com.nicico.sales.model.entities.base.WarehouseStock;
import com.nicico.sales.repository.WarehouseCadDAO;
import com.nicico.sales.repository.WarehouseCadItemDAO;
import com.nicico.sales.repository.WarehouseStockDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.nicico.copper.common.domain.criteria.SearchUtil.createSearchRq;
import static com.nicico.copper.common.domain.criteria.SearchUtil.mapSearchRs;

@RequiredArgsConstructor
@Service
public class WarehouseCadItemService implements IWarehouseCadItemService {

	private final WarehouseStockDAO warehouseStockDAO;
	private final WarehouseCadItemDAO warehouseCadItemDAO;
	private final WarehouseCadDAO warehouseCadDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSECADITEM')")
	public WarehouseCadItemDTO.Info get(Long id) {
		final Optional<WarehouseCadItem> slById = warehouseCadItemDAO.findById(id);
		final WarehouseCadItem warehouseCadItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));

		return modelMapper.map(warehouseCadItem, WarehouseCadItemDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECADITEM')")
	public List<WarehouseCadItemDTO.Info> list() {
		final List<WarehouseCadItem> slAll = warehouseCadItemDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<WarehouseCadItemDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('C_WAREHOUSECADITEM')")
	public WarehouseCadItemDTO.Info create(WarehouseCadItemDTO.Create request) {
		final WarehouseCadItem warehouseCadItem = modelMapper.map(request, WarehouseCadItem.class);
//		Optional<WarehouseCad> byId = warehouseCadDAO.findById(request.getWarehouseCadId());
//		final WarehouseCad warehouseCad = byId.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));
		warehouseCadItem.setWarehouseCadId(request.getWarehouseCadId());

		return save(warehouseCadItem, null);
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('U_WAREHOUSECADITEM')")
	public WarehouseCadItemDTO.Info update(Long id, WarehouseCadItemDTO.Update request) {
		final Optional<WarehouseCadItem> slById = warehouseCadItemDAO.findById(id);
		final WarehouseCadItem warehouseCadItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));

		WarehouseCadItem updating = new WarehouseCadItem();
		modelMapper.map(warehouseCadItem, updating);
		modelMapper.map(request, updating);

		return save(updating, warehouseCadItem);
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSECADITEM')")
	public void delete(Long id) {
		warehouseCadItemDAO.deleteById(id);
	}

	@Transactional
	@Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSECADITEM')")
	public void delete(WarehouseCadItemDTO.Delete request) {
		final List<WarehouseCadItem> warehouseCadItems = warehouseCadItemDAO.findAllById(request.getIds());

		warehouseCadItemDAO.deleteAll(warehouseCadItems);
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECADITEM')")
	public TotalResponse<WarehouseCadItemDTO.Info> search(MultiValueMap<String, String> criteria) {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		final SearchDTO.SearchRq request = createSearchRq(nicicoCriteria);

		final SearchDTO.CriteriaRq inputCriteriaRq = new SearchDTO.CriteriaRq();
		if (criteria.containsKey("warehouseCadId")) {
			inputCriteriaRq.setFieldName("warehouseCadId")
					.setOperator(EOperator.equals)
					.setValue(criteria.get("warehouseCadId").get(0));

			if (request.getCriteria() != null) {
				final List<SearchDTO.CriteriaRq> criteriaRqList = new ArrayList<>();

				criteriaRqList.add(request.getCriteria());
				criteriaRqList.add(inputCriteriaRq);

				final SearchDTO.CriteriaRq criteriaRq = new SearchDTO.CriteriaRq()
						.setOperator(EOperator.and)
						.setCriteria(criteriaRqList);

				request.setCriteria(criteriaRq);
			} else {
				request.setCriteria(inputCriteriaRq);
			}
		}

		final SearchDTO.SearchRs<WarehouseCadItemDTO.Info> response = search(request);
		return mapSearchRs(nicicoCriteria, response);
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECADITEM')")
	public SearchDTO.SearchRs<WarehouseCadItemDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(warehouseCadItemDAO, request, entity -> modelMapper.map(entity, WarehouseCadItemDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECATHODE')")
	public SearchDTO.SearchRs<WarehouseCadItemDTO.Info> search(WarehouseCadItemDTO.Delete request) {

		final List<SearchDTO.CriteriaRq> idCriteriaRqList = new ArrayList<>();

		SearchDTO.CriteriaRq idsCriteriaRq = new SearchDTO.CriteriaRq()
				.setOperator(EOperator.equals)
				.setFieldName("id")
				.setValue(request.getIds().stream().map(String::valueOf).collect(Collectors.toList()));
		idCriteriaRqList.add(idsCriteriaRq);

		final SearchDTO.CriteriaRq requestCriteriaRq = new SearchDTO.CriteriaRq()
				.setOperator(EOperator.and)
				.setCriteria(idCriteriaRqList);

		final SearchDTO.SearchRq searchRq = new SearchDTO.SearchRq()
				.setCount(0)
				.setCount(1000)
				.setCriteria(requestCriteriaRq);


		return SearchUtil.search(warehouseCadItemDAO, searchRq, warehouseCadItem -> modelMapper.map(warehouseCadItem, WarehouseCadItemDTO.Info.class));
	}


	public WarehouseCadItemDTO.Info save(WarehouseCadItem warehouseCadItem, WarehouseCadItem oldCadItem) {

	    final WarehouseCad bijak=warehouseCadDAO.findById(warehouseCadItem.getWarehouseCadId())
	    								.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));
		if (oldCadItem == null) {
			if (warehouseCadItem.getSheetNo()  == null) warehouseCadItem.setSheetNo(0L);
			if (warehouseCadItem.getBarrelNo() == null) warehouseCadItem.setBarrelNo(0L);
		}
		WarehouseStock stock = warehouseStockDAO.findByMaterialItemIdAndWarehouseYardIdAndPlantAndWarehouseNo(
				bijak.getMaterialItemId(),
				bijak.getWarehouseYardId(),
				bijak.getPlant(),
				bijak.getWarehouseNo());

		if (stock == null) {
			WarehouseStock warehouseStock = new WarehouseStock();
			warehouseStock.setMaterialItemId(bijak.getMaterialItemId());
			warehouseStock.setWarehouseYardId(bijak.getWarehouseYardId());
			warehouseStock.setPlant(bijak.getPlant());
			warehouseStock.setWarehouseNo(bijak.getWarehouseNo());

			warehouseStock.setAmount(warehouseCadItem.getWeightKg());
			warehouseStock.setBarrel(warehouseCadItem.getBarrelNo());
			warehouseStock.setBundle(warehouseCadItem.getBundleSerial() != null ? 1L : 0L);
			warehouseStock.setLot(warehouseCadItem.getLotName() != null ? 1L : 0L);
			warehouseStock.setSheet(warehouseCadItem.getSheetNo());

			warehouseStockDAO.saveAndFlush(warehouseStock);
		} else {
			if (oldCadItem == null) {  // eslahyeh nist
				stock.setAmount(stock.getAmount() + warehouseCadItem.getWeightKg());
				stock.setBundle(warehouseCadItem.getBundleSerial() == null ? stock.getBundle() : stock.getBundle() + 1L);
				stock.setLot(warehouseCadItem.getLotName() == null ? stock.getLot() : stock.getLot() + 1L);
				stock.setSheet(stock.getSheet() + warehouseCadItem.getSheetNo());
				stock.setBarrel(stock.getBarrel() + warehouseCadItem.getBarrelNo());
				warehouseStockDAO.saveAndFlush(stock);
			} else { //eslahyeh
				Double amountDiff = warehouseCadItem.getWeightKg() - oldCadItem.getWeightKg();
				Long barrelDiff = warehouseCadItem.getBarrelNo() - oldCadItem.getBarrelNo();
				Long sheetDiff = warehouseCadItem.getSheetNo() - oldCadItem.getSheetNo();
				if (!(amountDiff.equals(0L) && barrelDiff.equals(0L) && sheetDiff.equals(0L))) {
					stock.setAmount(stock.getAmount() + amountDiff);
					stock.setBarrel(stock.getBarrel() + barrelDiff);
					stock.setSheet(stock.getSheet() + sheetDiff);
					warehouseStockDAO.saveAndFlush(stock);
				}
			}
		}
		final WarehouseCadItem saved = warehouseCadItemDAO.saveAndFlush(warehouseCadItem);
		return modelMapper.map(saved, WarehouseCadItemDTO.Info.class);
	}
}
