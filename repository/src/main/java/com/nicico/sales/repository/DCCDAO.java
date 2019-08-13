package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.DCC;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface DCCDAO extends JpaRepository<DCC, Long>, JpaSpecificationExecutor<DCC> {

}
