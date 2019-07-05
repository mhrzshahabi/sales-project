package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.PaymentOptionContract;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymentOptionContractDAO extends JpaRepository<PaymentOptionContract, Long>, JpaSpecificationExecutor<PaymentOptionContract> {

}
