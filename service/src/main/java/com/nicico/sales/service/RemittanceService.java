package com.nicico.sales.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Sets;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.annotation.CheckCriteria;
import com.nicico.sales.dto.RemittanceDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IRemittanceService;
import com.nicico.sales.model.entities.warehouse.Remittance;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.repository.TozinDAO;
import com.nicico.sales.repository.TozinTableDAO;
import com.nicico.sales.repository.warehouse.InventoryDAO;
import com.nicico.sales.repository.warehouse.RemittanceDAO;
import com.nicico.sales.repository.warehouse.RemittanceDetailDAO;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
@Slf4j
public class RemittanceService extends GenericService<Remittance, Long, RemittanceDTO.Create, RemittanceDTO.Info, RemittanceDTO.Update, RemittanceDTO.Delete> implements IRemittanceService {
    private final RemittanceDetailDAO remittanceDetailDAO;
    private final RemittanceDAO remittanceDAO;
    private final InventoryDAO inventoryDAO;
    private final TozinTableDAO tozinTableDAO;
    private final TozinDAO tozinDAO;
    private final SpecListUtil specListUtil;
    private final ObjectMapper objectMapper;
    private final ModelMapper modelMapper;
    private final NamedParameterJdbcTemplate jdbcTemplate;

    @Override
    @Action(value = ActionType.DeleteAll)
    @Transactional
    public void deleteAll(RemittanceDTO.Delete request) {
        jdbcTemplate.update("DELETE FROM TBL_WARH_REMITTANCE_DETAIL WHERE F_REMITTANCE_ID in (:ids)",
                new HashMap() {{
                    put("ids", request.getIds());
                }});
        jdbcTemplate.update("DELETE FROM TBL_WARH_INVENTORY where id not in (SELECT DISTINCT F_INVENTORY_ID from " +
                "TBL_WARH_REMITTANCE_DETAIL)", new HashMap());

        jdbcTemplate.update("DELETE FROM TBL_WARH_TOZIN where id not in (SELECT DISTINCT F_SOURCE_TOZINE_ID tzn from " +
                "TBL_WARH_REMITTANCE_DETAIL UNION  SELECT DISTINCT F_DESTINATION_TOZINE_ID tzn" +
                " FROM TBL_WARH_REMITTANCE_DETAIL)", new HashMap());
        super.deleteAll(request);


    }

    @Action(value = ActionType.Get)
    @Transactional
    @Override
    public JsonDataSource print(MultiValueMap criteria) throws JsonProcessingException, JRException {
        NICICOCriteria provideNICICOCriteria = specListUtil.provideNICICOCriteria(criteria, RemittanceDTO.Info.class);
        List<RemittanceDTO.Info> data = search(provideNICICOCriteria).getResponse().getData();
        if (data == null) throw new NotFoundException();
        final List<RemittanceDTO.PDF> dataForPdf = modelMapper.map(data, new TypeToken<List<RemittanceDTO.PDF>>() {
        }.getType());
        dataForPdf.stream().forEach(remittancePDF -> {
            remittancePDF.setDepot(String.format("%s %s %s",
                    remittancePDF.getRemittanceDetails().get(0).getDepot().getStore().getWarehouse().getName(),
                    remittancePDF.getRemittanceDetails().get(0).getDepot().getStore().getName(),
                    remittancePDF.getRemittanceDetails().get(0).getDepot().getName()));
            remittancePDF.setMaterialItemName(remittancePDF.getRemittanceDetails().get(0).getInventory().getMaterialItem().getGdsName());
            remittancePDF.setIsWithRail(false);
            remittancePDF.setFrom(remittancePDF.getRemittanceDetails().get(0).getSourceTozin().getSourceWarehouse().getName());
            remittancePDF.setSourceDate(addSlashToDate(remittancePDF.getRemittanceDetails().get(0).getSourceTozin().getDate()));
            if (remittancePDF.getRemittanceDetails().get(0).getDestinationTozin() != null)
                remittancePDF.setDestinationDate(addSlashToDate(remittancePDF.getRemittanceDetails().get(0).getDestinationTozin().getDate()));
            final String containerNo3 = remittancePDF.getRemittanceDetails().get(0).getSourceTozin().getContainerNo3();
            try {
                Integer.valueOf(containerNo3);
                remittancePDF.setIsWithRail(true);
            } catch (Exception e) {
                log.debug(e.getMessage());
            }
        });
        final HashMap content = new HashMap() {{
            put("content", dataForPdf);
        }};
        /*
        try {
            objectMapper.writeValue(new File("/tmp/js.json"),content);
        } catch (IOException e) {
            log.debug(e.getMessage());
        }
-
         */
        JsonDataSource jsonDataSource = new JsonDataSource(
                new ByteArrayInputStream(objectMapper.writeValueAsString(content).getBytes(StandardCharsets.UTF_8))
        );
        return jsonDataSource;
    }

    private String addSlashToDate(String date) {
        final String year = date.substring(0, 4);
        final String month = date.substring(4, 6);
        final String day = date.substring(6, 8);
        return String.format("%s/%s/%s", year, month, day);
    }

    @Override
    @Transactional
    public List<String> getLotsByShipmentId(Long id) {

        final List<Remittance> remittances = remittanceDAO.findByShipmentId(id);
        return remittances.stream().
                map(Remittance::getRemittanceDetails).
                flatMap(remittanceDetails -> remittanceDetails.stream().
                        map(remittanceDetail -> remittanceDetail.getInventory().getLabel())).
                collect(Collectors.toList());
    }

    @Override
    public TotalResponse<RemittanceDTO.Lite> searchLite(NICICOCriteria request) {
        List<Remittance> entities = new ArrayList<>();
        final TotalResponse<RemittanceDTO.Lite> totalResponse = SearchUtil.search(remittanceDAO, request, entity -> {

            RemittanceDTO.Lite eResult = modelMapper.map(entity, RemittanceDTO.Lite.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });
        validationAll(entities, totalResponse);
        return totalResponse;
    }

    @Override
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public SearchDTO.SearchRs<RemittanceDTO.ReportInfo> reportSearch(SearchDTO.SearchRq request) {

        List<Remittance> entities = new ArrayList<>();
        SearchDTO.SearchRs<RemittanceDTO.ReportInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            RemittanceDTO.ReportInfo eResult = modelMapper.map(entity, RemittanceDTO.ReportInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @CheckCriteria
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public TotalResponse<RemittanceDTO.ReportInfo> reportSearch(NICICOCriteria request) {

        List<Remittance> entities = new ArrayList<>();
        TotalResponse<RemittanceDTO.ReportInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            RemittanceDTO.ReportInfo eResult = modelMapper.map(entity, RemittanceDTO.ReportInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }
}
