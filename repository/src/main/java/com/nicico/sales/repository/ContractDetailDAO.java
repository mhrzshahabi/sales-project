package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDetailDAO extends JpaRepository<ContractDetail, Long>, JpaSpecificationExecutor<ContractDetail> {

    @Query(nativeQuery = true,value = "select * from tbl_contract_detail tc where tc.contract_id=?1")
    ContractDetail findByContract_id(long id);

}
