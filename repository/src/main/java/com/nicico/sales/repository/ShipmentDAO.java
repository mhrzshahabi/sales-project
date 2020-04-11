package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Shipment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShipmentDAO extends JpaRepository<Shipment, Long>, JpaSpecificationExecutor<Shipment> {
    @Query(value = "            select cs.id cisId,c.c_CONTRACT_NO contractNo,a.C_FULLNAME_EN fullname,cs.amount amount,cs.ADDRESS address,cs.plan plan,cs.SEND_DATE sendDate, " +
            "                     cs.DURATION duration,a.ID contactID,m.id materialID,c.contract_id contractID,cs.DISCHARGE  dischargeID ,cs.address dischargeAddress,i.CODE " +
            "                     from TBL_CONTRACT_SHIPMENT cs  " +
            "                     join tbl_contract c on c.contract_id=cs.CONTRACT_ID  " +
            "                     join tbl_material m on m.id=c.MATERIAL_ID  " +
            "                     join tbl_contact a on a.ID=c.CONTACT_ID  " +
            "					  join tbl_incoterms i on c.INCOTERMS_ID = i.ID " +
            "                      where cs.id not in (select  xs.contract_shipment_id from tbl_shipment xs where  xs.contract_shipment_id=cs.id) and cs.DISCHARGE IS NOT NULL" +
            "                      and to_char(sysdate+15,'yyyy/mm/dd') > cs.SEND_DATE   ", nativeQuery = true)
    List<Object[]> pickListShipment();

    @Query(value = "select wl.lot_name  from tbl_warehouse_lot wl where wl.contract_id = :id ", nativeQuery = true)
    List<String> findLotname(@Param("id") String id);

    @Query(value = "select  wl.booking_no from tbl_warehouse_lot wl where wl.contract_id = :id ", nativeQuery = true)
    List<String> findbooking(@Param("id") String id);

    @Query(value = "select C_FULLNAME_EN from  tbl_contact where C_FULLNAME_EN  LIKE 'SGS' OR C_FULLNAME_EN LIKE 'AHK' ", nativeQuery = true)
    List<String> cname();

    @Query(value = "select   cont.c_fullname_en  AS cf   from  TBL_contact cont LEFT JOIN TBL_CONTRACT contr ON cont.ID = contr.CONTACT_ID    where (cont.b_inspector = 1)    AND    ( cont.c_fullname_en LIKE 'SGS' OR  cont.c_fullname_en  LIKE 'AHK' )", nativeQuery = true)
    List<String> inspector();
}
