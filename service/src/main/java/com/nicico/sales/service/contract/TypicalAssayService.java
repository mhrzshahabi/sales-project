package com.nicico.sales.service.contract;


import com.nicico.sales.dto.contract.TypicalAssayDTO;
import com.nicico.sales.iservice.contract.ITypicalAssayService;
import com.nicico.sales.model.entities.contract.TypicalAssay;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TypicalAssayService extends GenericService<TypicalAssay, Long, TypicalAssayDTO.Create, TypicalAssayDTO.Info, TypicalAssayDTO.Update, TypicalAssayDTO.Delete> implements ITypicalAssayService {
}
