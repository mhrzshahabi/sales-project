package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.CathodeList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CathodeListDAO extends JpaRepository<CathodeList, Long>, JpaSpecificationExecutor<CathodeList> {

}
