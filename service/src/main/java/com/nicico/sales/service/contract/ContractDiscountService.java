package com.nicico.sales.service.contract;

import com.google.gson.JsonObject;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.sales.dto.contract.ContractDiscountDTO;
import com.nicico.sales.exception.InvalidDataException;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.contract.IContractDiscountService;
import com.nicico.sales.model.entities.contract.ContractDiscount;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.Arrays;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractDiscountService extends GenericService<ContractDiscount, Long, ContractDiscountDTO.Create, ContractDiscountDTO.Info, ContractDiscountDTO.Update, ContractDiscountDTO.Delete> implements IContractDiscountService {

	@Override
	public ContractDiscountDTO.Info getByCuPercent(Double percent) {
		MultiValueMap searchTerm = new LinkedMultiValueMap();
		JsonObject criteria1 = new JsonObject();
		criteria1.addProperty("fieldName", "upperBound");
		criteria1.addProperty("operator", "greaterOrEqual");
		criteria1.addProperty("value", percent);
		JsonObject criteria2 = new JsonObject();
		criteria2.addProperty("fieldName", "lowerBound");
		criteria2.addProperty("operator", "lessThan");
		criteria2.addProperty("value", percent == 0 ? (1E-10) : percent);
		searchTerm.add("_constructor", "AdvancedCriteria");
        searchTerm.add("operator", "and");
        searchTerm.add("_operationType", "fetch");
        searchTerm.addAll("criteria", Arrays.asList(criteria1, criteria2));
		NICICOCriteria nicicoCriteria = NICICOCriteria.of(searchTerm);
		List<ContractDiscountDTO.Info> list = search(nicicoCriteria).getResponse().getData();
        if (list == null || list.size() == 0)
            throw new NotFoundException(ContractDiscount.class);
        if (list.size() > 1)
            throw new InvalidDataException();
        return list.get(0);
    }

}
