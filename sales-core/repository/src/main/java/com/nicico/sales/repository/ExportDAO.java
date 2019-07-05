package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Export;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ExportDAO extends JpaRepository<Export, Long>, JpaSpecificationExecutor<Export> {

}
