package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Goods;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface GoodsDAO extends JpaRepository<Goods, Long>, JpaSpecificationExecutor<Goods> {
    @Modifying
    @Query(value = "insert into TBL_GOODS (ID,C_NAME_FA, C_CREATED_BY, D_CREATED_DATE,   N_VERSION)" +
            "select distinct GDSCODE,GDSNAME,'fromView',current_date,0 from n_master.V_TOZINE_CONTENT_M", nativeQuery = true)
    void updateFromTozinView();
}
