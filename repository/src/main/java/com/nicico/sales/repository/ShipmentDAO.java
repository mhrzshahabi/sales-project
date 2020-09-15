package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Shipment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShipmentDAO extends JpaRepository<Shipment, Long>, JpaSpecificationExecutor<Shipment> {
    @Query(value = "            select cs.id cisId,c.c_CONTRACT_NO contractNo,a.C_FULLNAME_EN fullname,cs.quantity quantity,cs.SEND_DATE sendDate, " +
            "                     a.ID contactID,m.id materialID,m.c_DESCP materialDescp, c.contract_id contractID,cs.LOAD_PORT_ID loadPortID " +
            "                     from TBL_CONTRACT_SHIPMENT cs  " +
            "                     join tbl_contract c on c.contract_id=cs.CONTRACT_ID  " +
            "                     join tbl_material m on m.id=c.MATERIAL_ID  " +
            "                     join tbl_contact a on a.ID=c.CONTACT_ID  " +
            "                      where cs.id not in (select  xs.contract_shipment_id from tbl_shipment xs where  xs.contract_shipment_id=cs.id) and cs.LOAD_PORT_ID IS NOT NULL" +
            "                         ", nativeQuery = true)
    List<Object[]> pickListShipment();

    List<Shipment> findAllByContractShipmentIdIsIn(List<Long> ids);
}
