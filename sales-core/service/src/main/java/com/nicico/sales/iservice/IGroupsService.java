package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.GroupsDTO;

import java.util.List;

public interface IGroupsService {

	GroupsDTO.Info get(Long id);

	List<GroupsDTO.Info> list();

	GroupsDTO.Info create(GroupsDTO.Create request);

	GroupsDTO.Info update(Long id, GroupsDTO.Update request);

	void delete(Long id);

	void delete(GroupsDTO.Delete request);

	SearchDTO.SearchRs<GroupsDTO.Info> search(SearchDTO.SearchRq request);
}
