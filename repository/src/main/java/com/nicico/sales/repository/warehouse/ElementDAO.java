package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.Element;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ElementDAO extends JpaRepository<Element, Long>, JpaSpecificationExecutor<Element> {

}
