package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.IncotermParties;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IncotermPartiesDAO extends JpaRepository<IncotermParties, Long>, JpaSpecificationExecutor<IncotermParties> {

    void deleteAllByIncotermDetailId(@Param("incotermDetailId") Long incotermDetailId);

    List<IncotermParties> findAllByIncotermDetailId(@Param("incotermDetailId") Long incotermDetailId);
}
