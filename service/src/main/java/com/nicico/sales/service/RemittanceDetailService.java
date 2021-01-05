package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.annotation.CheckCriteria;
import com.nicico.sales.dto.InventoryDTO;
import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IRemittanceDetailService;
import com.nicico.sales.model.entities.base.Tozin;
import com.nicico.sales.model.entities.warehouse.Inventory;
import com.nicico.sales.model.entities.warehouse.Remittance;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.model.entities.warehouse.TozinTable;
import com.nicico.sales.repository.TozinDAO;
import com.nicico.sales.repository.TozinTableDAO;
import com.nicico.sales.repository.warehouse.InventoryDAO;
import com.nicico.sales.repository.warehouse.RemittanceDAO;
import com.nicico.sales.repository.warehouse.RemittanceDetailDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class RemittanceDetailService extends GenericService<RemittanceDetail, Long, RemittanceDetailDTO.Create, RemittanceDetailDTO.Info, RemittanceDetailDTO.Update, RemittanceDetailDTO.Delete> implements IRemittanceDetailService {
    private final RemittanceDAO remittanceDAO;
    private final RemittanceDetailDAO remittanceDetailDAO;
    private final InventoryDAO inventoryDAO;
    private final TozinTableDAO tozinTableDAO;
    private final TozinDAO tozinDAO;
    private final NamedParameterJdbcTemplate jdbcTemplate;

    @Action(value = ActionType.Update)
    @Transactional
    @Override
    public List<RemittanceDetailDTO.Info> batchUpdate(RemittanceDetailDTO.WithRemittanceAndInventory request) {
        Remittance remittanceSaved = remittanceDAO.save(modelMapper.map(request.getRemittance(), Remittance.class));
        List<RemittanceDetail> rds = new ArrayList<>();
        final List<RemittanceDetailDTO.WithInventory> remittanceDetailsList = request.getRemittanceDetails();
        Map<String, Long> tozinKeyValue = new HashMap<>();
        remittanceDetailsList.stream().forEach(rd -> {
            final TozinTable sourceTozin = modelMapper.map(rd.getSourceTozin(), TozinTable.class);
            final TozinTable destinationTozin = modelMapper.map(rd.getDestinationTozin(), TozinTable.class);
            saveTozin(tozinKeyValue, sourceTozin);
            saveTozin(tozinKeyValue, destinationTozin);
        });
        remittanceDetailsList.stream().forEach(rd -> {
            final InventoryDTO.Create inventory = rd.getInventory();
            final Inventory inventorySaved = inventoryDAO.save(modelMapper.map(inventory, Inventory.class));
            final RemittanceDetail remittanceDetail = modelMapper.map(rd, RemittanceDetail.class);
            remittanceDetail.setRemittanceId(remittanceSaved.getId());
            remittanceDetail.setInventoryId(inventorySaved.getId());
            remittanceDetail.setSourceTozinId(tozinKeyValue.get(rd.getSourceTozin().getTozinId()));
            remittanceDetail.setDestinationTozinId(tozinKeyValue.get(rd.getDestinationTozin().getTozinId()));
            rds.add(remittanceDetail);
        });
        final List<RemittanceDetail> remittanceDetails = repository.saveAll(rds);
        return modelMapper.map(remittanceDetails, new TypeToken<List<RemittanceDetailDTO.Info>>() {
        }.getType());
    }

    @Action(value = ActionType.Create)
    @Override
    @Transactional
    public List<RemittanceDetailDTO.Info> out(RemittanceDetailDTO.OutRemittance request) {
        final Long remittanceId = remittanceDAO.save(modelMapper.map(request.getRemittance(), Remittance.class)).getId();
        List<RemittanceDetail> details = new ArrayList<>();
        Map<String, TozinTable> tozinTableSet = new HashMap();
        request.getRemittanceDetails().stream().forEach(rd -> {
            final String tozinId = rd.getSourceTozin().getTozinId();
            if (!tozinTableSet.containsKey(tozinId))
                tozinTableSet.put(tozinId, tozinTableDAO.saveAndFlush(modelMapper.map(rd.getSourceTozin(), TozinTable.class)));
        });
        request
                .getRemittanceDetails()
                .parallelStream()
                .forEach(r -> {
                    final RemittanceDetail remittanceDetail = modelMapper.map(r, RemittanceDetail.class);
                    remittanceDetail.setSourceTozinId(tozinTableSet.get(r.getSourceTozin().getTozinId()).getId());
                    remittanceDetail.setRemittanceId(remittanceId);
                    details.add(remittanceDetail);
                });

        final List<RemittanceDetail> remittanceDetailList = repository.saveAll(details);
        final List<RemittanceDetailDTO.Info> infoList = modelMapper.map(remittanceDetailList, new TypeToken<List<RemittanceDetailDTO.Info>>() {
        }.getType());
        return infoList;
    }

    @Override
    @Transactional(propagation = Propagation.NEVER)
    public List<Long> outWeight(RemittanceDetailDTO.OutRemittanceWeight request) {
        final List<List<Long>> count_weight = remittanceDetailDAO.remittanceDetailByWeightCount(request.getTozin().getVazn(), request.getSourceList(),
                request.getTargetId());
        final Remittance remittance = modelMapper.map(request.getRemittance(), Remittance.class);
        final Remittance savedRemittance = remittanceDAO.save(remittance);
        final TozinTable tozinTable = modelMapper.map(request.getTozin(), TozinTable.class);
        final TozinTable savedTozin = tozinTableDAO.save(tozinTable);
        String query = "insert into TBL_WARH_REMITTANCE_DETAIL\n" +
                "(id, c_created_by, d_created_date, n_version, n_e_status, b_editable, n_amount,\n" +
                " f_depot_id,  f_inventory_id,\n" +
                " f_remittance_id,  f_source_tozine_id, f_unit_id, n_weight)\n" +
                "with initial_criteria as (\n" +
                "    select * from TMP_RD_INV_T where TARGETID = :target_id and FIRST_SOURCEID in (:source_id_list)\n" +
                "),\n" +
                "     base_on_sum_tmp as (select SUM_WEIGHT SUM_WEIGHT, DAT DAT\n" +
                "                     from initial_criteria\n" +
                "                     where ROWNUM = 1\n" +
                "                       and dat = (select max(DAT)\n" +
                "                                  from initial_criteria\n" +
                "                                  where SUM_WEIGHT < :total_weight)),\n" +
                " base_on_sum_1 as (\n" +
                "         select SUM_WEIGHT, DAT\n" +
                "         from base_on_sum_tmp\n" +
                "         union\n" +
                "         select SUM_WEIGHT, dat\n" +
                "         from (select 0 as SUM_WEIGHT, '0' as dat from dual))\n" +
                "        ,\n" +
                "     base_on_sum as (\n" +
                "         select SUM_WEIGHT, DAT\n" +
                "         from base_on_sum_1\n" +
                "         order by dat desc\n" +
                "             fetch FIRST row only\n" +
                "     )" +
                "     ,remained as (select :total_weight - (select SUM_WEIGHT from base_on_sum) r from dual)\n" +
                "      ,t_20 as (\n" +
                "         select *\n" +
                "         from initial_criteria\n" +
                "         where N_WEIGHT = 20000\n" +
                "           and dat > (select DAT from base_on_sum)\n" +
                "           and ROWNUM <= FLOOR((select r from remained) / 20000))\n" +
                "     ,t_4 as (\n" +
                "         select *\n" +
                "         from initial_criteria\n" +
                "         where N_WEIGHT = 4000\n" +
                "           and dat > (select DAT from base_on_sum)\n" +
                "           and ROWNUM <= FLOOR(mod((select r from remained), 20000) / 4000)),\n" +
                "     t_2 as (\n" +
                "         select *\n" +
                "         from initial_criteria\n" +
                "         where N_WEIGHT = 2000\n" +
                "           and dat > (select DAT from base_on_sum)\n" +
                "           and ROWNUM <= FLOOR(mod((select r from remained), 4000) / 2000)),\n" +
                "     t_1 as (\n" +
                "         select *\n" +
                "         from initial_criteria\n" +
                "         where N_WEIGHT = 1000\n" +
                "           and dat > (select DAT from base_on_sum)\n" +
                "           and ROWNUM <= FLOOR(mod((select r from remained), 2000) / 1000)),\n" +
                "     t_500_k as (\n" +
                "         select *\n" +
                "         from initial_criteria\n" +
                "         where N_WEIGHT = 500\n" +
                "           and dat > (select DAT from base_on_sum)\n" +
                "           and ROWNUM <= FLOOR(mod((select r from remained), 1000) / 500)),\n" +
                "     under_500_1 as (select *\n" +
                "                     from initial_criteria\n" +
                "                     where dat > (select dat from base_on_sum)\n" +
                "                       and N_WEIGHT <= mod((select r from remained), 500)\n" +
                "                     order by N_WEIGHT desc),\n" +
                "     under_500_2 as (select *\n" +
                "                     from initial_criteria\n" +
                "                     where dat > (select dat from base_on_sum)\n" +
                "                       and ID != (select id from under_500_1 where ROWNUM = 1)\n" +
                "                       and N_WEIGHT <=\n" +
                "                           mod((select r from remained), 500) - (select N_WEIGHT from under_500_1 where ROWNUM = 1)\n" +
                "                     order by N_WEIGHT desc),\n" +
                "     under_500_3 as (select *\n" +
                "                     from initial_criteria\n" +
                "                     where dat > (select dat from base_on_sum)\n" +
                "                       and ID != (select id from under_500_1 where ROWNUM = 1)\n" +
                "                       and ID != (select id from under_500_2 where ROWNUM = 1)\n" +
                "                       and N_WEIGHT <=\n" +
                "                           mod((select r from remained), 500) - (select N_WEIGHT from under_500_1 where ROWNUM = 1) -\n" +
                "                           (select N_WEIGHT from under_500_2 where ROWNUM = 1)\n" +
                "                     order by N_WEIGHT desc)\n" +
                "        ,\n" +
                "     result as (\n" +
                "         select *\n" +
                "         from under_500_1\n" +
                "         where ROWNUM = 1\n" +
                "         union\n" +
                "         select *\n" +
                "         from under_500_2\n" +
                "         where ROWNUM = 1\n" +
                "         union\n" +
                "         select *\n" +
                "         from under_500_3\n" +
                "         where ROWNUM = 1\n" +
                "         union\n" +
                "         select *\n" +
                "         from initial_criteria\n" +
                "         where DAT <= (select dat from base_on_sum)\n" +
                "         union\n" +
                "         select *\n" +
                "         from t_20\n" +
                "         union\n" +
                "         select *\n" +
                "         from t_4\n" +
                "         union\n" +
                "         select *\n" +
                "         from t_2\n" +
                "         union\n" +
                "         select *\n" +
                "         from t_1\n" +
                "         union\n" +
                "         select *\n" +
                "         from t_500_k\n" +
                "     )" +
                "--      id, c_created_by, d_created_date, n_version, n_e_status, b_editable, n_amount,\n" +
                "--      f_depot_id,  f_inventory_id,\n" +
                "--      f_remittance_id,  f_source_tozine_id, f_unit_id, n_weight\n" +
                "select\n" +
                "SEQ_WARH_REMITTANCE_DETAIL.nextval,\n" +
                "       :created_by,current_timestamp,0,1,1,N_AMOUNT,F_DEPOT_ID,id,:remittance_id,:source_tozin_id,F_UNIT_ID,N_WEIGHT\n" +
                "from result\n";
        jdbcTemplate.update(query, new HashMap() {{
                    put("total_weight", request.getTozin().getVazn());
                    put("source_id_list", request.getSourceList());
                    put("target_id", request.getTargetId());
                    put("created_by", savedRemittance.getCreatedBy());
                    put("remittance_id", savedRemittance.getId());
                    put("source_tozin_id", savedTozin.getId());
                }}

        );

        return remittanceDetailDAO.remittanceDetailByWeight(savedRemittance.getId(), savedTozin.getId());
    }

    private void saveTozin(Map<String, Long> tozinKeyValue, TozinTable tozinTable) {
        if (!tozinKeyValue.containsKey(tozinTable.getTozinId())) {
            final Tozin tozin = tozinDAO.findFirstByTozinId(tozinTable.getTozinId());
            if (tozin != null) {
                final TozinTable tozinToSave = modelMapper.map(tozin, TozinTable.class);
                tozinToSave.setDriverName(tozinTable.getDriverName());
                tozinKeyValue.put(tozinTable.getTozinId(), tozinTableDAO.save(tozinToSave).getId());
            } else tozinKeyValue.put(tozinTable.getTozinId(), tozinTableDAO.save(tozinTable).getId());
        }
    }

    @Override
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public SearchDTO.SearchRs<RemittanceDetailDTO.ReportInfo> reportSearch(SearchDTO.SearchRq request) {

        List<RemittanceDetail> entities = new ArrayList<>();
        SearchDTO.SearchRs<RemittanceDetailDTO.ReportInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            RemittanceDetailDTO.ReportInfo eResult = modelMapper.map(entity, RemittanceDetailDTO.ReportInfo.class);
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
    public TotalResponse<RemittanceDetailDTO.ReportInfo> reportSearch(NICICOCriteria request) {

        List<RemittanceDetail> entities = new ArrayList<>();
        TotalResponse<RemittanceDetailDTO.ReportInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            RemittanceDetailDTO.ReportInfo eResult = modelMapper.map(entity, RemittanceDetailDTO.ReportInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }
}
