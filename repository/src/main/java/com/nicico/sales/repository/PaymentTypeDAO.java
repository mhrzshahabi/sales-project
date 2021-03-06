package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.PaymentType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymentTypeDAO extends JpaRepository<PaymentType, Long>, JpaSpecificationExecutor<PaymentType> {

}
