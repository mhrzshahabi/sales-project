package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.CDTPDynamicTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CDTPDynamicTableDAO extends JpaRepository<CDTPDynamicTable, Long>, JpaSpecificationExecutor<CDTPDynamicTable> {

    List<CDTPDynamicTable> findAllByCdtpId(Long id);
}
