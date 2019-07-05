package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.PaymentOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymentOptionDAO extends JpaRepository<PaymentOption, Long>, JpaSpecificationExecutor<PaymentOption> {

}
