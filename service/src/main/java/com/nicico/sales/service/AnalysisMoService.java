package com.nicico.sales.service;


import com.nicico.sales.dto.AnalysisMoDTO;
import com.nicico.sales.iservice.IAnalysisMoService;
import com.nicico.sales.model.entities.base.AnalysisMo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AnalysisMoService extends GenericService<AnalysisMo,Long , AnalysisMoDTO.Create , AnalysisMoDTO.Info , AnalysisMoDTO.Update , AnalysisMoDTO.Delete> implements IAnalysisMoService {
}
