package com.nicico.sales.iservice.contract;

import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;

import java.util.List;
import java.util.Map;

public interface IContractDetailValueService2 {

	Map<String, List<Object>> get(Long contractId, EContractDetailTypeCode contractDetailTypeCode, EContractDetailValueKey contractDetailValueKey,Boolean finalized);
}
