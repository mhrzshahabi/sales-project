package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Glossary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface GlossaryDAO extends JpaRepository<Glossary, Long>, JpaSpecificationExecutor<Glossary> {

}
