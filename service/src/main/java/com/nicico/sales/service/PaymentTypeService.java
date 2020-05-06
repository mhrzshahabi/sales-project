package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PaymentTypeDTO;
import com.nicico.sales.iservice.IPaymentTypeService;
import com.nicico.sales.model.entities.base.PaymentType;
import com.nicico.sales.repository.PaymentTypeDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class PaymentTypeService implements IPaymentTypeService {

    private final PaymentTypeDAO paymentTypeDAO;
    private final ModelMapper modelMapper;


    @Transactional(readOnly = true)
    @Override
    public List<PaymentTypeDTO.Info> list() {
        final List<PaymentType> slAll = paymentTypeDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<PaymentTypeDTO.Info>>() {
        }.getType());
    }


    @Transactional(readOnly = true)
    @Override
    public TotalResponse<PaymentTypeDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(paymentTypeDAO, criteria, paymentType  -> modelMapper.map(paymentType, PaymentTypeDTO.Info.class));
    }

}
