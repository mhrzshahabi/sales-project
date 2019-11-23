package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.MaterialItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface MaterialItemDAO extends JpaRepository<MaterialItem, Long>, JpaSpecificationExecutor<MaterialItem> {
    MaterialItem findByGdsCode(String gdsCode);
}
