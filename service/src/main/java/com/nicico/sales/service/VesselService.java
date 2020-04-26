package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.VesselDTO;
import com.nicico.sales.iservice.IVesselService;
import com.nicico.sales.model.entities.base.Vessel;
import com.nicico.sales.repository.VesselDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class VesselService implements IVesselService {

    private final VesselDAO vesselDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_BANK')")
    public VesselDTO.Info get(Long id) {
        final Optional<Vessel> slById = vesselDAO.findById(id);
        final Vessel vessel = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.VesselNotFound));

        return modelMapper.map(vessel, VesselDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_BANK')")
    public List<VesselDTO.Info> list() {
        final List<Vessel> slAll = vesselDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<VesselDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_BANK')")
    public VesselDTO.Info create(VesselDTO.Create request) {
        final Vessel vessel = modelMapper.map(request, Vessel.class);

        return save(vessel);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_BANK')")
    public VesselDTO.Info update(Long id, VesselDTO.Update request) {
        final Optional<Vessel> slById = vesselDAO.findById(id);
        final Vessel vessel = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.VesselNotFound));

        Vessel updating = new Vessel();
        modelMapper.map(vessel, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_BANK')")
    public void delete(Long id) {
        vesselDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_BANK')")
    public void delete(VesselDTO.Delete request) {
        final List<Vessel> vessels = vesselDAO.findAllById(request.getIds());

        vesselDAO.deleteAll(vessels);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_BANK')")
    public TotalResponse<VesselDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(vesselDAO, criteria, vessel -> modelMapper.map(vessel, VesselDTO.Info.class));
    }

    private VesselDTO.Info save(Vessel vessel) {
        final Vessel saved = vesselDAO.saveAndFlush(vessel);
        return modelMapper.map(saved, VesselDTO.Info.class);
    }
}
