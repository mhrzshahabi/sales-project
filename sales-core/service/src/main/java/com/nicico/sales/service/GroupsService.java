package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.GroupsDTO;
import com.nicico.sales.iservice.IGroupsService;
import com.nicico.sales.model.entities.base.Groups;
import com.nicico.sales.repository.GroupsDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class GroupsService implements IGroupsService {

	private final GroupsDAO groupsDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public GroupsDTO.Info get(Long id) {
		final Optional<Groups> slById = groupsDAO.findById(id);
		final Groups groups = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.GroupsNotFound));

		return modelMapper.map(groups, GroupsDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<GroupsDTO.Info> list() {
		final List<Groups> slAll = groupsDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<GroupsDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public GroupsDTO.Info create(GroupsDTO.Create request) {
		final Groups groups = modelMapper.map(request, Groups.class);

		return save(groups);
	}

	@Transactional
	@Override
	public GroupsDTO.Info update(Long id, GroupsDTO.Update request) {
		final Optional<Groups> slById = groupsDAO.findById(id);
		final Groups groups = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.GroupsNotFound));

		Groups updating = new Groups();
		modelMapper.map(groups, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		groupsDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(GroupsDTO.Delete request) {
		final List<Groups> groupss = groupsDAO.findAllById(request.getIds());

		groupsDAO.deleteAll(groupss);
	}

	public SearchDTO.SearchRs<GroupsDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(groupsDAO, request, groups -> modelMapper.map(groups, GroupsDTO.Info.class));
	}

	// ------------------------------

	private GroupsDTO.Info save(Groups groups) {
		final Groups saved = groupsDAO.saveAndFlush(groups);
		return modelMapper.map(saved, GroupsDTO.Info.class);
	}
}
