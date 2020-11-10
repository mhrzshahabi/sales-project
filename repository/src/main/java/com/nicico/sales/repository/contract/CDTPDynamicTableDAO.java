package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.CDTPDynamicTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface CDTPDynamicTableDAO extends JpaRepository<CDTPDynamicTable, Long>, JpaSpecificationExecutor<CDTPDynamicTable> {
    void deleteAllByCdtpIdIn(List<Long> cdtpIds);

    @Query("select ctpdt.id from CDTPDynamicTable ctpdt where ctpdt.cdtpId=:cdtpId")
    Set<Long> getIdsByCtpId(Long cdtpId);

    void deleteAllByIdIn(Set<Long> ids);
}
