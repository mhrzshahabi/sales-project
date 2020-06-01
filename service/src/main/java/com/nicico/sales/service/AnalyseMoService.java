package com.nicico.sales.service;


import com.nicico.sales.dto.AnalyseMoDTO;
import com.nicico.sales.iservice.IAnalyseMoService;
import com.nicico.sales.model.entities.base.AnalyseMo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AnalyseMoService extends GenericService<AnalyseMo ,Long , AnalyseMoDTO.Create , AnalyseMoDTO.Info , AnalyseMoDTO.Update , AnalyseMoDTO.Delete> implements IAnalyseMoService {
}
