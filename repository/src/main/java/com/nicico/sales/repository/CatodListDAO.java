package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.CatodList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface CatodListDAO extends JpaRepository<CatodList, Long>, JpaSpecificationExecutor<CatodList> {

}
