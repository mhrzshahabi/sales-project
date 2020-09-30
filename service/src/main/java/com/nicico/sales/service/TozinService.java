package com.nicico.sales.service;

import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.model.entities.base.Tozin;
import com.nicico.sales.repository.TozinDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Set;

@Slf4j
@RequiredArgsConstructor
@Service
public class TozinService extends GenericService<Tozin, Long, TozinDTO, TozinDTO.Info, TozinDTO, TozinDTO> implements ITozinService {

    @Override
    public Set<Tozin> getAllByTozinIdIn(Set<String> tozinIdList) {
        return ((TozinDAO)repository).getAllByTozinIdIn(tozinIdList);
    }
}
