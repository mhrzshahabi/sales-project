package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.RawMaterial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface RawMaterialDAO extends JpaRepository<RawMaterial, Long>, JpaSpecificationExecutor<RawMaterial> {

}
