package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.ItemDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ItemDetailDAO extends JpaRepository<ItemDetail, Long>, JpaSpecificationExecutor<ItemDetail> {
    Optional<ItemDetail> findById(Long id);
}
