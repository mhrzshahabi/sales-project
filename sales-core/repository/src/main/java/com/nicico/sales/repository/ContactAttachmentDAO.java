package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.ContactAttachment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ContactAttachmentDAO extends JpaRepository<ContactAttachment, Long>, JpaSpecificationExecutor<ContactAttachment> {
	@Query(value = "SELECT SALES.SEQ_IMAGE_NUMBER.nextval FROM dual ", nativeQuery = true)
	public Long findNextImageNumber();
}
