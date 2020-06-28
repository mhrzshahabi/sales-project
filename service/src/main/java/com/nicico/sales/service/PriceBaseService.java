package com.nicico.sales.service;

import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.repository.PriceBaseDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<PriceBase, Long, PriceBaseDTO.Create, PriceBaseDTO.Info, PriceBaseDTO.Update, PriceBaseDTO.Delete> implements IPriceBaseService {

    @Override
    public BigDecimal calculateElementPrice(Integer year, Integer month, Long elementId) {

        List<PriceBase> prices = ((PriceBaseDAO) repository).getAllPrices(year, month, elementId);
        BigDecimal averagePrice = BigDecimal.ZERO;
        if (prices.size() > 0)
            averagePrice = prices.stream().map(PriceBase::getPrice).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(prices.size()), RoundingMode.HALF_EVEN);

        return averagePrice;
    }
}
