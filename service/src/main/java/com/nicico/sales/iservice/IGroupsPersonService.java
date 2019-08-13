package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.GroupsPersonDTO;

import java.util.List;

public interface IGroupsPersonService {

	GroupsPersonDTO.Info get(Long id);

	List<GroupsPersonDTO.Info> list();

	GroupsPersonDTO.Info create(GroupsPersonDTO.Create request);

	GroupsPersonDTO.Info update(Long id, GroupsPersonDTO.Update request);

	void delete(Long id);

	void delete(GroupsPersonDTO.Delete request);

	SearchDTO.SearchRs<GroupsPersonDTO.Info> search(SearchDTO.SearchRq request);
}
