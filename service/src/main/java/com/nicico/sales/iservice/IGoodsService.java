package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.GoodsDTO;

import java.util.List;

public interface IGoodsService {
    void updateFromTozinView();

    GoodsDTO.Info get(Long id);

    List<GoodsDTO.Info> list();

    TotalResponse<GoodsDTO.Info> search(NICICOCriteria nicicoCriteria);

}
