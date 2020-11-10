package com.nicico.sales.iservice.contract;


import com.nicico.sales.dto.PackingListDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.warehouse.PackingList;

public interface IPackingListService extends IGenericService<PackingList, Long, PackingListDTO.Create, PackingListDTO.Info, PackingListDTO.Update, PackingListDTO.Delete> {

}
