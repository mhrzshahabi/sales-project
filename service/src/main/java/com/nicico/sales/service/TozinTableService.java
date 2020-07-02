package com.nicico.sales.service;

import com.nicico.sales.dto.TozinTableDTO;
import com.nicico.sales.iservice.ITozinTableService;
import com.nicico.sales.model.entities.warehouse.TozinTable;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class TozinTableService extends GenericService<TozinTable, Long,
        TozinTableDTO.Create, TozinTableDTO.Info, TozinTableDTO.Update, TozinTableDTO.Delete> implements ITozinTableService {

}
