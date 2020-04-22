package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.Tozin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface TozinDAO extends JpaRepository<Tozin, Long>, JpaSpecificationExecutor<Tozin> {

}
