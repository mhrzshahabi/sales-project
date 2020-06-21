package com.nicico.sales.service;


import com.nicico.sales.dto.TypicalAssayDTO;
import com.nicico.sales.iservice.ITypicalAssayService;
import com.nicico.sales.model.entities.base.TypicalAssay;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TypicalAssayService extends GenericService<TypicalAssay,Long , TypicalAssayDTO.Create , TypicalAssayDTO.Info , TypicalAssayDTO.Update , TypicalAssayDTO.Delete> implements ITypicalAssayService {
}
