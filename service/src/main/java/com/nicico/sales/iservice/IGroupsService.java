package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.GroupsDTO;

import java.util.List;

public interface IGroupsService {

    GroupsDTO.Info get(Long id);

    List<GroupsDTO.Info> list();

    GroupsDTO.Info create(GroupsDTO.Create request);

    GroupsDTO.Info update(Long id, GroupsDTO.Update request);

    void delete(Long id);

    void deleteAll(GroupsDTO.Delete request);

    TotalResponse<GroupsDTO.Info> search(NICICOCriteria criteria);
}
