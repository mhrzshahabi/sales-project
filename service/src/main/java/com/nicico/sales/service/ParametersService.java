package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ParametersDTO;
import com.nicico.sales.iservice.IParametersService;
import com.nicico.sales.model.entities.base.Parameters;
import com.nicico.sales.repository.ParametersDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ParametersService implements IParametersService {

    private final ParametersDAO parametersDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_PARAMETERS')")
    public ParametersDTO.Info get(Long id) {
        final Optional<Parameters> slById = parametersDAO.findById(id);
        final Parameters parameters = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ParametersNotFound));

        return modelMapper.map(parameters, ParametersDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_PARAMETERS')")
    public List<ParametersDTO.Info> list() {
        final List<Parameters> slAll = parametersDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ParametersDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_PARAMETERS')")
    public ParametersDTO.Info create(ParametersDTO.Create request) {
        final Parameters parameters = modelMapper.map(request, Parameters.class);

        return save(parameters);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_PARAMETERS')")
    public ParametersDTO.Info update(Long id, ParametersDTO.Update request) {
        final Optional<Parameters> slById = parametersDAO.findById(id);
        final Parameters parameters = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ParametersNotFound));

        Parameters updating = new Parameters();
        modelMapper.map(parameters, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_PARAMETERS')")
    public void delete(Long id) {
        parametersDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_PARAMETERS')")
    public void delete(ParametersDTO.Delete request) {
        final List<Parameters> parameterss = parametersDAO.findAllById(request.getIds());

        parametersDAO.deleteAll(parameterss);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_PARAMETERS')")
    public SearchDTO.SearchRs<ParametersDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(parametersDAO, request, parameters -> modelMapper.map(parameters, ParametersDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_PARAMETERS')")
    public TotalResponse<ParametersDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(parametersDAO, criteria, parameters -> modelMapper.map(parameters, ParametersDTO.Info.class));
    }

    private ParametersDTO.Info save(Parameters parameters) {
        final Parameters saved = parametersDAO.saveAndFlush(parameters);
        return modelMapper.map(saved, ParametersDTO.Info.class);
    }
}
