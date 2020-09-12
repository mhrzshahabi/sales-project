package com.nicico.sales.service.contract;

import com.google.gson.JsonObject;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.sales.dto.contract.ContractDiscountDto;
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
public class ContractDiscountService extends GenericService<ContractDiscount, Long, ContractDiscountDto.Create, ContractDiscountDto.Info, ContractDiscountDto.Update, ContractDiscountDto.Delete> implements IContractDiscountService {

    @Override
    public ContractDiscountDto.Info getByCuPercent(Double percent) {
        MultiValueMap searchTerm = new LinkedMultiValueMap();
        JsonObject criteria1 = new JsonObject();
        criteria1.addProperty("fieldName", "upperBound");
        criteria1.addProperty("operator", "lessOrEqual");
        criteria1.addProperty("value", percent);
        JsonObject criteria2 = new JsonObject();
        criteria2.addProperty("fieldName", "lowerBound");
        criteria2.addProperty("operator", "greaterThan");
        criteria2.addProperty("value", percent == 0 ? (1E-10) : percent);
        searchTerm.add("_constructor", "AdvancedCriteria");
        searchTerm.add("operator", "and");
        searchTerm.add("_operationType", "fetch");
        searchTerm.addAll("criteria", Arrays.asList(criteria1, criteria2));
        NICICOCriteria nicicoCriteria = NICICOCriteria.of(searchTerm);
        List<ContractDiscountDto.Info> list = search(nicicoCriteria).getResponse().getData();
        if (list == null || list.size() == 0)
            throw new NotFoundException(ContractDiscount.class);
        if (list.size() > 1)
            throw new InvalidDataException();
        return list.get(0);
    }

}
