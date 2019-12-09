package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseCadItemDTO;
import com.nicico.sales.iservice.IWarehouseCadItemService;
import com.nicico.sales.model.entities.base.WarehouseCad;
import com.nicico.sales.model.entities.base.WarehouseCadItem;
import com.nicico.sales.model.entities.base.WarehouseLot;
import com.nicico.sales.model.entities.base.WarehouseStock;
import com.nicico.sales.repository.WarehouseCadDAO;
import com.nicico.sales.repository.WarehouseCadItemDAO;
import com.nicico.sales.repository.WarehouseLotDAO;
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
	private final WarehouseLotDAO warehouseLotDAO;

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
		final WarehouseCadItem warehouseCadItem = warehouseCadItemDAO.findById(id)
		.orElseThrow(()->new SalesException(SalesException.ErrorType.WarehouseCadItemNotFound));
		final WarehouseCad bijak = warehouseCadDAO.findById(warehouseCadItem.getWarehouseCadId())
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));
		WarehouseStock stock = warehouseStockDAO.findByMaterialItemIdAndWarehouseYardIdAndPlantAndWarehouseNo(
				bijak.getMaterialItemId(),
				bijak.getWarehouseYardId(),
				bijak.getPlant(),
				bijak.getWarehouseNo());

		stock.setAmount(stock.getAmount() - warehouseCadItem.getWeightKg());
		stock.setBundle(warehouseCadItem.getBundleSerial() == null ? stock.getBundle() : stock.getBundle() - 1L);
		stock.setLot(warehouseCadItem.getLotName() == null ? stock.getLot() : stock.getLot() - 1L);
		stock.setSheet(stock.getSheet() - warehouseCadItem.getSheetNo());
		stock.setBarrel(stock.getBarrel() - warehouseCadItem.getBarrelNo());
		warehouseStockDAO.saveAndFlush(stock);

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

		final WarehouseCad bijak = warehouseCadDAO.findById(warehouseCadItem.getWarehouseCadId())
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));
		if (oldCadItem == null) {
			if (warehouseCadItem.getSheetNo() == null) warehouseCadItem.setSheetNo(0L);
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
			warehouseStock.setPlant(plantEng(bijak.getPlant()));
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
		// update WarehouseLot if Material is MO
		if (bijak.getMaterialItemId() == 13) {
			WarehouseLot warehouseLot = warehouseLotDAO.findByLotName(warehouseCadItem.getLotName());
			if (warehouseLot == null) {
				WarehouseLot wh = new WarehouseLot();
				wh.setLotName(warehouseCadItem.getLotName());
				wh.setMaterialId(bijak.getMaterialItem().getMaterialId());
				wh.setPlant(plantEng(bijak.getPlant()));
				wh.setWarehouseNo("3");
				wh.setWeightKg(warehouseCadItem.getWeightKg());
				wh.setWarehouseCadItemId(warehouseCadItem.getId());
				wh.setUsed(false);
				warehouseLotDAO.saveAndFlush(wh);
			} else {
				warehouseLot.setPlant(plantEng(bijak.getPlant()));
				warehouseLot.setWarehouseNo("3");
				warehouseLot.setWarehouseCadItemId(warehouseCadItem.getId());
				warehouseLotDAO.saveAndFlush(warehouseLot);
			}
		}
		final WarehouseCadItem saved = warehouseCadItemDAO.saveAndFlush(warehouseCadItem);
		return modelMapper.map(saved, WarehouseCadItemDTO.Info.class);
	}

	public WarehouseCadItemDTO.Info saveIssue(WarehouseCadItem warehouseCadItem, Long issueId) {

		if ((warehouseCadItem.getIssueId() == null && issueId==null) ||
		     (warehouseCadItem.getIssueId() != null && issueId!=null && warehouseCadItem.getIssueId().equals(issueId)))
			return modelMapper.map(warehouseCadItem, WarehouseCadItemDTO.Info.class);
		else if (issueId != null && warehouseCadItem.getIssueId() != null) {
			warehouseCadItem.setIssueId(issueId);
			final WarehouseCadItem saved = warehouseCadItemDAO.saveAndFlush(warehouseCadItem);
			return modelMapper.map(saved, WarehouseCadItemDTO.Info.class);
		}

	    final WarehouseCad bijak=warehouseCadDAO.findById(warehouseCadItem.getWarehouseCadId())
	    								.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));
		WarehouseStock stock = warehouseStockDAO.findByMaterialItemIdAndWarehouseYardIdAndPlantAndWarehouseNo(
				bijak.getMaterialItemId(),
				bijak.getWarehouseYardId(),
				bijak.getPlant(),
				bijak.getWarehouseNo());

		 if (issueId != null && warehouseCadItem.getIssueId() == null) { // kasr az mojodi
					stock.setAmount(stock.getAmount() - warehouseCadItem.getWeightKg());
					stock.setBarrel(stock.getBarrel() - warehouseCadItem.getBarrelNo());
					stock.setSheet(stock.getSheet() - warehouseCadItem.getSheetNo());
					stock.setBundle(warehouseCadItem.getBundleSerial() == null ? stock.getBundle() : stock.getBundle() - 1L);
					stock.setLot(warehouseCadItem.getLotName() == null ? stock.getLot() : stock.getLot() - 1L);

		} else if(issueId == null && warehouseCadItem.getIssueId()!=null ) { // ezafeh be mojodi
					stock.setAmount(stock.getAmount() + warehouseCadItem.getWeightKg());
					stock.setBarrel(stock.getBarrel() + warehouseCadItem.getBarrelNo());
					stock.setSheet(stock.getSheet() + warehouseCadItem.getSheetNo());
					stock.setBundle(warehouseCadItem.getBundleSerial() == null ? stock.getBundle() : stock.getBundle() + 1L);
					stock.setLot(warehouseCadItem.getLotName() == null ? stock.getLot() : stock.getLot() + 1L);
		}
		warehouseStockDAO.saveAndFlush(stock);

		warehouseCadItem.setIssueId(issueId);
		final WarehouseCadItem saved = warehouseCadItemDAO.saveAndFlush(warehouseCadItem);
		return modelMapper.map(saved, WarehouseCadItemDTO.Info.class);
	}

	private String plantEng(String plantFa) {
		if (plantFa.equals("مجتمع مس شهربابك -ميدوك ") || plantFa.equals("مجتمع مس شهربابك - خاتون آباد "))
			return "Miduk";
		if (plantFa.equals("بندرعباس") || plantFa.equals("اسكله شهيد رجائي "))
			return "BandarAbbas";
		if (plantFa.equals("ايستگاه قطار تبريز") || plantFa.equals("مجتمع مس سونگون "))
			return "sungun";
		if (plantFa.equals("مجتمع مس سرچشمه"))
			return "Sarcheshmeh";
		return plantFa;
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECAD')")
	public TotalResponse< WarehouseCadItemDTO.InfoCombo2> search1(NICICOCriteria criteria) {
		List<WarehouseCadItem> l = warehouseCadItemDAO.findOnHandsByHSCode("74031100");
		GridResponse< WarehouseCadItemDTO.InfoCombo2> gridResponse = new GridResponse();
		List< WarehouseCadItemDTO.InfoCombo2> data = new ArrayList<>();
		for (WarehouseCadItem w : l) {
			data.add(modelMapper.map(w,  WarehouseCadItemDTO.InfoCombo2.class) );
		}
		gridResponse.setStartRow(0);
		gridResponse.setEndRow(data.size()-1);
		gridResponse.setTotalRows(data.size());
		gridResponse.setData(data );
		return new TotalResponse<>(gridResponse);
	}

}
