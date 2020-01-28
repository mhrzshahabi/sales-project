package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.GroupsDTO;

import java.util.List;

public interface IGroupsService {

	GroupsDTO.Info get(Long id);

	List<GroupsDTO.Info> list();

	GroupsDTO.Info create(GroupsDTO.Create request);

	GroupsDTO.Info update(Long id, GroupsDTO.Update request);

	void delete(Long id);

	void delete(GroupsDTO.Delete request);

	TotalResponse<GroupsDTO.Info> search(NICICOCriteria criteria);
}
