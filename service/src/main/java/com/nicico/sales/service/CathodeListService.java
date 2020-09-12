package com.nicico.sales.service;

import com.nicico.sales.dto.CathodeListDTO;
import com.nicico.sales.iservice.ICathodeListService;
import com.nicico.sales.model.entities.base.CathodeList;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class CathodeListService extends GenericService<CathodeList, CathodeList.CathodeListId, CathodeListDTO, CathodeListDTO.Info, CathodeListDTO, CathodeListDTO> implements ICathodeListService {
}
