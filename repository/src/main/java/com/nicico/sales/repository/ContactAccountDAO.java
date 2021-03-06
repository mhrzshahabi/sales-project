package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContactAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContactAccountDAO extends JpaRepository<ContactAccount, Long>, JpaSpecificationExecutor<ContactAccount> {
    List<ContactAccount> findByContactId(Long contactId);
}
