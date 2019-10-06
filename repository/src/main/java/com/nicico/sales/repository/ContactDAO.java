package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Contact;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContactDAO extends JpaRepository<Contact, Long>, JpaSpecificationExecutor<Contact> {

    Contact findByNameFA(String s);
}
