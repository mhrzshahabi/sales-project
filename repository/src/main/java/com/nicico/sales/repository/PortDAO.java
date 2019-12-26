package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Port;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface PortDAO extends JpaRepository<Port, Long>, JpaSpecificationExecutor<Port> {

}
