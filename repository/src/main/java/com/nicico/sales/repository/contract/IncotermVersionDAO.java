package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.IncotermVersion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface IncotermVersionDAO extends JpaRepository<IncotermVersion, Long>, JpaSpecificationExecutor<IncotermVersion> {

}
