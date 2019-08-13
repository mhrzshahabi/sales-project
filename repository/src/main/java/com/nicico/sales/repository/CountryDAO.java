package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Country;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface CountryDAO extends JpaRepository<Country, Long>, JpaSpecificationExecutor<Country> {

}
