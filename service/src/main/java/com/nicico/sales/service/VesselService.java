package com.nicico.sales.service;

import com.nicico.sales.dto.VesselDTO;
import com.nicico.sales.iservice.IVesselService;
import com.nicico.sales.model.entities.base.Vessel;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class VesselService extends GenericService<Vessel, Long, VesselDTO.Create, VesselDTO.Info, VesselDTO.Update, VesselDTO.Delete> implements IVesselService {

}
