package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.GroupsPersonDTO;

import java.util.List;

public interface IGroupsPersonService {

    GroupsPersonDTO.Info get(Long id);

    List<GroupsPersonDTO.Info> list();

    GroupsPersonDTO.Info create(GroupsPersonDTO.Create request);

    GroupsPersonDTO.Info update(Long id, GroupsPersonDTO.Update request);

    void delete(Long id);

    void deleteAll(GroupsPersonDTO.Delete request);

    TotalResponse<GroupsPersonDTO.Info> search(NICICOCriteria criteria);
}
