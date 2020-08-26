package com.nicico.sales.service;

import com.nicico.sales.iservice.ITozinLiteService;
import com.nicico.sales.model.entities.base.TozinLite;
import com.nicico.sales.repository.TozinLiteDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Set;

@Slf4j
@RequiredArgsConstructor
@Service
public class TozinLiteService extends GenericService<TozinLite, Long, TozinLite, TozinLite, TozinLite, TozinLite> implements ITozinLiteService {
    @Override
    public Set<TozinLite> findAllByTozinIdIn(Set<String> tozinIdList) {
        return ((TozinLiteDAO) repository).findAllByTozinIdIn(tozinIdList);
    }
}
