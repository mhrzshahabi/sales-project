package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.GoodsDTO;
import com.nicico.sales.iservice.IGoodsService;
import com.nicico.sales.model.entities.base.Goods;
import com.nicico.sales.repository.GoodsDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class GoodsService implements IGoodsService {

    private final GoodsDAO dao;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public void updateFromTozinView() {
        dao.deleteAll();
        dao.updateFromTozinView();
    }

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public GoodsDTO.Info get(Long id) {
        final Optional<Goods> slById = dao.findById(id);
        final Goods Goods = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));

        return modelMapper.map(Goods, GoodsDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public List<GoodsDTO.Info> list() {
        final List<Goods> slAll = dao.findAll();

        return modelMapper.map(slAll, new TypeToken<List<GoodsDTO.Info>>() {
        }.getType());
    }


    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public TotalResponse<GoodsDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(dao, criteria, Goods -> modelMapper.map(Goods, GoodsDTO.Info.class));
    }

}
