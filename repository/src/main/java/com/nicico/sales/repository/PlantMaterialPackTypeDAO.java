    package com.nicico.sales.repository;


    //import ir.fava.report.model.ReportInfo;

    import com.nicico.sales.model.entities.base.myModel.PMPTYPE;
    import org.springframework.data.jpa.repository.JpaRepository;
    import org.springframework.data.jpa.repository.Query;
    import org.springframework.data.repository.query.Param;
    import org.springframework.stereotype.Repository;

    @Repository
    public interface PlantMaterialPackTypeDAO extends JpaRepository<PMPTYPE, Long> {
        String finding = "select * from TBL_Interpreter i where i.GDSCODE = :gsdcode and i.PACK_TYPE = :Packetype and i.PLANT_ID = :Plantid";

        @Query(value = finding, nativeQuery = true)
        PMPTYPE findAllByGDSCODEAndPLANT_IDAndPACK_TYPE(@Param("gsdcode") Long gsdcode, @Param("Plantid") Long Plantid, @Param("Packetype") Long Packetype);

        @Query(value = "select * from TBL_Interpreter t where t.P_ID =:id " , nativeQuery = true)
        PMPTYPE findAllByP_id(@Param("id") Long id);
    }
