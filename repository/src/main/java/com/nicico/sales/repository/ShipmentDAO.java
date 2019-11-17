package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Shipment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShipmentDAO extends JpaRepository<Shipment, Long>, JpaSpecificationExecutor<Shipment> {
    //cisId,contractNo,fullname,amount,address,plan,sendDate,duration,contactID,materialID,contractID,dischargeID,dischargeAddress,code(incoterms)
    @Query(value = "            select cs.id cisId,c.c_CONTRACT_NO contractNo,a.C_FULLNAME_EN fullname,cs.amount amount,cs.ADDRESS address,cs.plan plan,cs.SEND_DATE sendDate, " +
            "                     cs.DURATION duration,a.ID contactID,m.id materialID,c.id contractID,cs.DISCHARGE  dischargeID ,cs.address dischargeAddress,i.CODE " +
            "                     from TBL_CONTRACT_SHIPMENT cs  " +
            "                     join tbl_contract c on c.id=cs.CONTRACT_ID  " +
            "                     join tbl_material m on m.id=c.MATERIAL_ID  " +
            "                     join tbl_contact a on a.ID=c.CONTACT_ID  " +
            "					  join tbl_incoterms i on c.INCOTERMS_ID = i.ID " +
            "                      where cs.id not in (select  xs.contract_shipment_id from tbl_shipment xs where  xs.contract_shipment_id=cs.id) and cs.DISCHARGE IS NOT NULL" +
            "                      and to_char(sysdate+15,'yyyy/mm/dd') > cs.SEND_DATE   ", nativeQuery = true)
    List<Object[]> pickListShipment();

    Shipment findByBlDate(String blDate);

    Shipment findByLoadingLetterAndBlNumbersIsNotNull(String loadingLetter);

/*Add By Jalal For */
    @Query(value = "select wl.lot_name from tbl_warehouse_lot wl where wl.contract_id = :id ", nativeQuery = true)
    List<String> findLotname(String id );


}
