package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InspectionContract;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InspectionContractDAO extends JpaRepository<InspectionContract, Long>, JpaSpecificationExecutor<InspectionContract> {

    @Query(value = "select EMAIL , EMAIL1 , EMAIL2  from TBL_PERSON INNER JOIN TBL_CONTACT TC on TBL_PERSON.CONTACT_ID = TC.ID where TBL_PERSON.CONTACT_ID =:id", nativeQuery = true)
    List<String> email(@Param("id") Long id);

}
