package com.nicico.sales.utility;

import com.nicico.sales.repository.contract.ContractDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ContractNoGenerator {

    private final ContractDAO contractDAO2;

    public String createContractNo() {

        return String.format("%04d", contractDAO2.findNextContractSequence());
    }
}
