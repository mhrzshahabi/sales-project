package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.Inventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface InventoryDAO extends JpaRepository<Inventory, Long>, JpaSpecificationExecutor<Inventory> {
    void deleteAllByIdIn(Set<Long> ids);

}
