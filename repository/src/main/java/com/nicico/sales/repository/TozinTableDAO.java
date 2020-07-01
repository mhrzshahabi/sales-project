package com.nicico.sales.repository;


import com.nicico.sales.model.entities.warehouse.TozinTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface TozinTableDAO extends JpaRepository<TozinTable, Long>, JpaSpecificationExecutor<TozinTable> {
    TozinTable findFirstByTozinId(String tozinId);

}
