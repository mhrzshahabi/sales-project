package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractAttachment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractAttachmentDAO extends JpaRepository<ContractAttachment, Long>, JpaSpecificationExecutor<ContractAttachment> {

}
