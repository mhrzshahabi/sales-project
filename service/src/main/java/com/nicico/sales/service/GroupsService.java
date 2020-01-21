package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.GroupsDTO;
import com.nicico.sales.iservice.IGroupsService;
import com.nicico.sales.model.entities.base.Groups;
import com.nicico.sales.repository.GroupsDAO;
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
public class GroupsService implements IGroupsService {

    private final GroupsDAO groupsDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_GROUPS')")
    public GroupsDTO.Info get(Long id) {
        final Optional<Groups> slById = groupsDAO.findById(id);
        final Groups groups = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.GroupsNotFound));

        return modelMapper.map(groups, GroupsDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_GROUPS')")
    public List<GroupsDTO.Info> list() {
        final List<Groups> slAll = groupsDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<GroupsDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_GROUPS')")
    public GroupsDTO.Info create(GroupsDTO.Create request) {
        final Groups groups = modelMapper.map(request, Groups.class);

        return save(groups);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_GROUPS')")
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
    @PreAuthorize("hasAuthority('D_GROUPS')")
    public void delete(Long id) {
        groupsDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_GROUPS')")
    public void delete(GroupsDTO.Delete request) {
        final List<Groups> groupss = groupsDAO.findAllById(request.getIds());

        groupsDAO.deleteAll(groupss);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_GROUPS')")
    public SearchDTO.SearchRs<GroupsDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(groupsDAO, request, groups -> modelMapper.map(groups, GroupsDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_GROUPS')")
    public TotalResponse<GroupsDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(groupsDAO, criteria, groups -> modelMapper.map(groups, GroupsDTO.Info.class));
    }

    private GroupsDTO.Info save(Groups groups) {
        final Groups saved = groupsDAO.saveAndFlush(groups);
        return modelMapper.map(saved, GroupsDTO.Info.class);
    }
}
