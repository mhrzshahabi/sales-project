package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.TozinLite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface TozinLiteDAO extends JpaRepository<TozinLite, Long>, JpaSpecificationExecutor<TozinLite> {
    Set<TozinLite> findAllByTozinIdIn(Set<String> tozinIdList);
    Set<TozinLite> findAllByTozinIdIn(List<String> tozinIdList);

}
