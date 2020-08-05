package com.nicico.sales.service;


import com.nicico.sales.dto.PortDTO;
import com.nicico.sales.iservice.IPortService;
import com.nicico.sales.model.entities.base.Port;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class PortService extends GenericService<Port, Long, PortDTO.Create, PortDTO.Info, PortDTO.Update, PortDTO.Delete> implements IPortService {


}