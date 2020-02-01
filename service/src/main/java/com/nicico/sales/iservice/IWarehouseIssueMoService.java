package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseIssueMoDTO;

import java.util.List;

public interface IWarehouseIssueMoService {

    WarehouseIssueMoDTO.Info get(Long id);

    List<WarehouseIssueMoDTO.Info> list();

    WarehouseIssueMoDTO.Info create(WarehouseIssueMoDTO.Create request);

    WarehouseIssueMoDTO.Info update(Long id, WarehouseIssueMoDTO.Update request);

    void delete(Long id);

    void delete(WarehouseIssueMoDTO.Delete request);

    TotalResponse<WarehouseIssueMoDTO.Info> search(NICICOCriteria criteria);
}
