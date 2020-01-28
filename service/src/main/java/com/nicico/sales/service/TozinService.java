package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.model.entities.base.MaterialItem;
import com.nicico.sales.model.entities.base.Tozin;
import com.nicico.sales.model.entities.base.WarehouseCad;
import com.nicico.sales.repository.MaterialItemDAO;
import com.nicico.sales.repository.TozinDAO;
import com.nicico.sales.repository.WarehouseCadDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import static com.nicico.copper.common.domain.criteria.SearchUtil.createSearchRq;
import static com.nicico.copper.common.domain.criteria.SearchUtil.mapSearchRs;

@Slf4j
@RequiredArgsConstructor
@Service
public class TozinService implements ITozinService {

    private final TozinDAO tozinDAO;
    private final WarehouseCadDAO warehouseCadDAO;
    private final MaterialItemDAO materialItemDAO;
    private final ModelMapper modelMapper;
    private final ObjectMapper objectMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_TOZIN')")
    public TozinDTO.Info get(Long id) {
        final Optional<Tozin> slById = tozinDAO.findById(id);
        final Tozin tozin = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.TozinNotFound));

        return modelMapper.map(tozin, TozinDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_TOZIN')")
    public List<TozinDTO.Info> list() {
        final List<Tozin> slAll = tozinDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<TozinDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_TOZIN')")
    public TozinDTO.Info create(TozinDTO.Create request) {
        final Tozin tozin = modelMapper.map(request, Tozin.class);

        return save(tozin);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_TOZIN')")
    public TozinDTO.Info update(Long id, TozinDTO.Update request) {
        final Optional<Tozin> slById = tozinDAO.findById(id);
        final Tozin tozin = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.TozinNotFound));

        Tozin updating = new Tozin();
        modelMapper.map(tozin, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_TOZIN')")
    public void delete(Long id) {
        tozinDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_TOZIN')")
    public void delete(TozinDTO.Delete request) {
        final List<Tozin> tozins = tozinDAO.findAllById(request.getIds());

        tozinDAO.deleteAll(tozins);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_TOZIN')")
    public TotalResponse<TozinDTO.Info> searchTozin(NICICOCriteria criteria) {
        return SearchUtil.search(tozinDAO, criteria, tozin -> modelMapper.map(tozin, TozinDTO.Info.class));
    }


    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_TOZIN')")
    public TotalResponse<TozinDTO.Info> searchTozinOnTheWay(NICICOCriteria criteria, String tozin) {
        final Map<String, Object> fetchedData = new HashMap<>();
        ((List) criteria.getCriteria()).forEach(nicicoCriteria -> {
            try {
                Map<String, Object> criteriaMap = objectMapper.readValue(nicicoCriteria.toString(), HashMap.class);
                if (criteriaMap.get("fieldName").equals("codeKala"))
                    fetchedData.put("codeKala", criteriaMap.get("value"));
            } catch (IOException e) {
                log.error("searchTozinOnTheWay error: {}", e.getMessage());
            }
        });
        MaterialItem materialItem = materialItemDAO.findByGdsCode(fetchedData.get("codeKala").toString());

        Set<WarehouseCad> bijacks = warehouseCadDAO.getAllByMaterialItemId(materialItem.getId());

        final List<String> sourceTozinPlantIds = new ArrayList<>();

        if (tozin.equals("SourceTozin"))
            sourceTozinPlantIds.addAll(bijacks.stream().map(WarehouseCad::getSourceTozinPlantId).collect(Collectors.toList()));
        else //  "DestTozin"
            sourceTozinPlantIds.addAll(bijacks.stream().map(WarehouseCad::getDestinationTozinPlantId).collect(Collectors.toList()));

        final List<SearchDTO.CriteriaRq> requestCriteriaRqList = new ArrayList<>();
        if (!CollectionUtils.isEmpty(sourceTozinPlantIds)) {
            final SearchDTO.CriteriaRq systemTypeCriteriaRq = new SearchDTO.CriteriaRq()
                    .setOperator(EOperator.notEqual)
                    .setFieldName("tozinPlantId")
                    .setValue(sourceTozinPlantIds);

            requestCriteriaRqList.add(systemTypeCriteriaRq);
        }

        final SearchDTO.SearchRq request = createSearchRq(criteria);

        if (request.getCriteria() != null) {
            requestCriteriaRqList.add(request.getCriteria());
        }

        SearchDTO.CriteriaRq requestCriteriaRq = new SearchDTO.CriteriaRq()
                .setOperator(EOperator.and)
                .setCriteria(requestCriteriaRqList);

        request.setCriteria(requestCriteriaRq);

        final SearchDTO.SearchRs<TozinDTO.Info> response = SearchUtil.search(tozinDAO, request, systemType -> modelMapper.map(systemType, TozinDTO.Info.class));

        return mapSearchRs(criteria, response);

    }

    private TozinDTO.Info save(Tozin tozin) {
        final Tozin saved = tozinDAO.saveAndFlush(tozin);
        return modelMapper.map(saved, TozinDTO.Info.class);
    }

    @PreAuthorize("hasAuthority('R_TOZIN')")
    public List<Object[]> findTransport2Plants(String date, String plantId) {
        return tozinDAO.findTransport2Plants(date, plantId);
    }

    @PreAuthorize("hasAuthority('R_TOZIN')")
    public String[] findPlants() {
        return tozinDAO.findPlants();
    }
}
