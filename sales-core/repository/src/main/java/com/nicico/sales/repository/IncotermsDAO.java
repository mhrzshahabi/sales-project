package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Incoterms;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface IncotermsDAO extends JpaRepository<Incoterms, Long>, JpaSpecificationExecutor<Incoterms> {

}
