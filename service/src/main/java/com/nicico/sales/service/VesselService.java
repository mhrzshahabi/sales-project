package com.nicico.sales.service;

import com.nicico.sales.dto.VesselDTO;
import com.nicico.sales.iservice.IVesselService;
import com.nicico.sales.model.entities.base.Vessel;
import com.nicico.sales.repository.VesselDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class VesselService extends GenericService<Vessel, Long, VesselDTO.Create, VesselDTO.Info, VesselDTO.Update, VesselDTO.Delete> implements IVesselService {

    private final VesselDAO vesselDAO;


    @Transactional
    @Override
    public void delete(VesselDTO.Delete request) {
        final List<Vessel> vessels = vesselDAO.findAllById(request.getIds());
        vesselDAO.deleteAll(vessels);
    }
}
