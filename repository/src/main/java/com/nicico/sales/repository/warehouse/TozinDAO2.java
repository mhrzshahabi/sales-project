package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.TozinTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface TozinDAO2 extends JpaRepository<TozinTable, Long>, JpaSpecificationExecutor<TozinTable> {
//    List<Tozin2> findByIdTozinId(String tozinId);


}
