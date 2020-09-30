package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDiscountDTO;
import com.nicico.sales.iservice.contract.IContractDiscountService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contract-discount")
public class ContractDiscountRestController {

    private final IContractDiscountService discountService;

	@Loggable
	@GetMapping(value = "/{cuPercent}")
	public ResponseEntity<ContractDiscountDTO> getByCuPercent(@PathVariable Double cuPercent) {
		return new ResponseEntity<>(discountService.getByCuPercent(cuPercent), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	public ResponseEntity<List<ContractDiscountDTO.Info>> list() {
		return new ResponseEntity<>(discountService.list(), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	public ResponseEntity<TotalResponse<ContractDiscountDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(discountService.search(nicicoCriteria), HttpStatus.OK);
	}

}
