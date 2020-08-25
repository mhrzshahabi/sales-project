package com.nicico.sales.service;

import com.nicico.sales.dto.PaymentTypeDTO;
import com.nicico.sales.iservice.IPaymentTypeService;
import com.nicico.sales.model.entities.base.PaymentType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class PaymentTypeService extends GenericService<PaymentType, Long, PaymentTypeDTO.Create, PaymentTypeDTO.Info, PaymentTypeDTO.Update, PaymentTypeDTO.Delete> implements IPaymentTypeService {
}
