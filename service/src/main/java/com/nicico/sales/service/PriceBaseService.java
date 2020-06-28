package com.nicico.sales.service;

import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.repository.PriceBaseDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<PriceBase, Long, PriceBaseDTO.Create, PriceBaseDTO.Info, PriceBaseDTO.Update, PriceBaseDTO.Delete> implements IPriceBaseService {
    private final PriceBaseDAO priceBaseDAO;

    @Override
    public List<PriceBase> findAllByPriceBaseMonth(Integer year, Integer month) {
        return priceBaseDAO.findAllByPriceBaseMonth(year, month);
    }
}
