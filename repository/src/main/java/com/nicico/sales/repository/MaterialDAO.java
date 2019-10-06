package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Material;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface MaterialDAO extends JpaRepository<Material, Long>, JpaSpecificationExecutor<Material> {

    Material findByDescl(String s);
}
