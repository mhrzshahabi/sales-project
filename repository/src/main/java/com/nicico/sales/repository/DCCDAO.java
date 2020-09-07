package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.DCC;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface DCCDAO extends JpaRepository<DCC, Long>, JpaSpecificationExecutor<DCC> {
    @Query(value = "SELECT SEQ_DCC.nextval FROM dual ", nativeQuery = true)
    Long findNextImageNumber();

     // @Query(value = "SELECT SEQ_DCC.nextval FROM dual ", nativeQuery = true)

    DCC getByFileNewName(String fileNewName);
}
