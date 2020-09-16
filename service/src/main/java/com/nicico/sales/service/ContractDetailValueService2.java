package com.nicico.sales.service;

import com.nicico.sales.dto.*;
import com.nicico.sales.dto.contract.ContractDiscountDTO;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IContractDetailValueService2;
import com.nicico.sales.model.entities.base.*;
import com.nicico.sales.model.entities.contract.Contract2;
import com.nicico.sales.model.entities.contract.ContractDetailValue;
import com.nicico.sales.model.entities.contract.ContractDiscount;
import com.nicico.sales.model.entities.contract.Incoterm;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.repository.*;
import com.nicico.sales.repository.contract.ContractDAO2;
import com.nicico.sales.repository.contract.ContractDetailValueDAO;
import com.nicico.sales.repository.contract.IncotermDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Slf4j
@RequiredArgsConstructor
@Service
public class ContractDetailValueService2 implements IContractDetailValueService2 {

    private final ContractDAO2 contractDAO2;
    private final ContractDetailValueDAO contractDetailValueDAO;

    private final TypicalAssayDAO typicalAssayDAO;
    private final BankDAO bankDAO;
    private final ContractDiscountDAO contractDiscountDAO;
    private final PortDAO portDAO;
    private final ContractShipmentDAO contractShipmentDAO;
    private final IncotermDAO incotermDAO;
    private final CountryDAO countryDAO;
    private final UnitDAO unitDAO;
    private final ContactDAO contactDAO;

    private final ModelMapper modelMapper;

    // ------------------------------

    @Transactional(readOnly = true)
    @Override
    public Map<String, List<Object>> get(Long contractId, EContractDetailTypeCode contractDetailTypeCode,
                                         EContractDetailValueKey contractDetailValueKey, Boolean finalized) {
        if (finalized == null) finalized = true;
        final Contract2 contract = contractDAO2.findById(contractId)
                .orElseThrow(() -> new SalesException2(ErrorType.NotFound, "id", "شناسه موجودیت یافت نشد."));

        if (contract.getParentId() != null)
            throw new SalesException2(ErrorType.invalidData, "id", "شناسه موجودیت صحیح نمی باشد.");

        final Map<String, List<Object>> result = new HashMap<>();
        if (contract.getAppendixContracts() != null && contract.getAppendixContracts().size() != 0) {
            contract.getAppendixContracts().sort((Contract2 c1, Contract2 c2) -> c2.getAffectFrom().compareTo(c1.getAffectFrom()));

            final Date now = new Date();
            for (Contract2 appendixContract : contract.getAppendixContracts()) {
                if (finalized ? !appendixContract.getEStatus().contains(EStatus.Final) : Boolean.FALSE)
                    continue;

                if (now.before(appendixContract.getAffectFrom()))
                    continue;

                List<ContractDetailValue> contractDetailValues;
                if (contractDetailValueKey != null && !contractDetailValueKey.equals(EContractDetailValueKey.NotImportant)) {
                    contractDetailValues = contractDetailValueDAO.findAllByContractIdAndDetailCodeAndValueKey(appendixContract.getId(), contractDetailTypeCode.getId(), contractDetailValueKey.name());
                } else {
                    contractDetailValues = contractDetailValueDAO.findAllByContractIdAndDetailCode(appendixContract.getId(), contractDetailTypeCode.getId());
                }

                if (contractDetailValues != null && contractDetailValues.size() > 0) {
                    contractDetailValuesProcessor(contractDetailValues, result);

                    break;
                }
            }
        }

        if (result.size() == 0) {
            if (finalized ? contract.getEStatus().contains(EStatus.Final) : Boolean.FALSE) {
                List<ContractDetailValue> contractDetailValues;
                if (contractDetailValueKey != null && !contractDetailValueKey.equals(EContractDetailValueKey.NotImportant)) {
                    contractDetailValues = contractDetailValueDAO.findAllByContractIdAndDetailCodeAndValueKey(contract.getId(), contractDetailTypeCode.getId(), contractDetailValueKey.name());
                } else {
                    contractDetailValues = contractDetailValueDAO.findAllByContractIdAndDetailCode(contract.getId(), contractDetailTypeCode.getId());
                }

                if (contractDetailValues != null && contractDetailValues.size() > 0)
                    contractDetailValuesProcessor(contractDetailValues, result);
            }
        }

        return result;
    }

    private void contractDetailValuesProcessor(List<ContractDetailValue> contractDetailValues, Map<String, List<Object>> result) {
        contractDetailValues.forEach(contractDetailValue -> {
            if (contractDetailValue.getReference() != null && !contractDetailValue.getReference().startsWith("Enum_")) {
                if (!result.containsKey(contractDetailValue.getKey()))
                    result.put(contractDetailValue.getKey(), new ArrayList<>(Arrays.asList((getValue(contractDetailValue)))));
                else
                    result.get(contractDetailValue.getKey()).add(getValue(contractDetailValue));
            } else {
                if (!result.containsKey(contractDetailValue.getKey()))
                    result.put(contractDetailValue.getKey(), new ArrayList<>(Arrays.asList((contractDetailValue.getValue()))));
                else
                    result.get(contractDetailValue.getKey()).add(contractDetailValue.getValue());
            }

        });
    }

    private Object getValue(ContractDetailValue contractDetailValue) {
        switch (contractDetailValue.getReference().trim()) {
            case "TypicalAssay":
                final Optional<TypicalAssay> typicalAssayOpt = typicalAssayDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (typicalAssayOpt.isPresent())
                    return modelMapper.map(typicalAssayOpt.get(), TypicalAssayDTO.Info.class);
                break;
            case "Bank":
                final Optional<Bank> bankOpt = bankDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (bankOpt.isPresent())
                    return modelMapper.map(bankOpt.get(), BankDTO.Info.class);
                break;
            case "Discount":
                final Optional<ContractDiscount> contractDiscountOpt = contractDiscountDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (contractDiscountOpt.isPresent())
                    return modelMapper.map(contractDiscountOpt.get(), ContractDiscountDTO.Info.class);
                break;
            case "Port":
                final Optional<Port> portOpt = portDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (portOpt.isPresent())
                    return modelMapper.map(portOpt.get(), PortDTO.Info.class);
                break;
            case "ContractShipment":
                final Optional<ContractShipment> contractShipmentOpt = contractShipmentDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (contractShipmentOpt.isPresent())
                    return modelMapper.map(contractShipmentOpt.get(), ContractShipmentDTO.Info.class);
                break;
            case "Incoterm":
                final Optional<Incoterm> incotermOpt = incotermDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (incotermOpt.isPresent())
                    return modelMapper.map(incotermOpt.get(), IncotermDTO.Info.class);
                break;
            case "Country":
                final Optional<Country> countryOpt = countryDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (countryOpt.isPresent())
                    return modelMapper.map(countryOpt.get(), CountryDTO.Info.class);
                break;
            case "Unit":
                final Optional<Unit> unitOpt = unitDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (unitOpt.isPresent())
                    return modelMapper.map(unitOpt.get(), UnitDTO.Info.class);
                break;
            case "Contact":
                final Optional<Contact> contactOpt = contactDAO.findById(Long.valueOf(contractDetailValue.getValue()));

                if (contactOpt.isPresent())
                    return modelMapper.map(contactOpt.get(), ContactDTO.Info.class);
                break;
        }

        return null;
    }
}
