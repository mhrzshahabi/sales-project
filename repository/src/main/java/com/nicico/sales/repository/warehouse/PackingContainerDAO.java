package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.PackingContainer;
import com.nicico.sales.model.entities.warehouse.PackingList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface PackingContainerDAO extends JpaRepository<PackingContainer, Long>, JpaSpecificationExecutor<PackingContainer> {

}
