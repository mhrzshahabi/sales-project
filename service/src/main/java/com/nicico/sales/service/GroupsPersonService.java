package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.GroupsPersonDTO;
import com.nicico.sales.iservice.IGroupsPersonService;
import com.nicico.sales.model.entities.base.GroupsPerson;
import com.nicico.sales.repository.GroupsPersonDAO;
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
public class GroupsPersonService implements IGroupsPersonService {

    private final GroupsPersonDAO groupsPersonDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_GROUPS_PERSON')")
    public GroupsPersonDTO.Info get(Long id) {
        final Optional<GroupsPerson> slById = groupsPersonDAO.findById(id);
        final GroupsPerson groupsPerson = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.GroupsPersonNotFound));

        return modelMapper.map(groupsPerson, GroupsPersonDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_GROUPS_PERSON')")
    public List<GroupsPersonDTO.Info> list() {
        final List<GroupsPerson> slAll = groupsPersonDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<GroupsPersonDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_GROUPS_PERSON')")
    public GroupsPersonDTO.Info create(GroupsPersonDTO.Create request) {
        final GroupsPerson groupsPerson = modelMapper.map(request, GroupsPerson.class);

        return save(groupsPerson);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_GROUPS_PERSON')")
    public GroupsPersonDTO.Info update(Long id, GroupsPersonDTO.Update request) {
        final Optional<GroupsPerson> slById = groupsPersonDAO.findById(id);
        final GroupsPerson groupsPerson = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.GroupsPersonNotFound));

        GroupsPerson updating = new GroupsPerson();
        modelMapper.map(groupsPerson, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_GROUPS_PERSON')")
    public void delete(Long id) {
        groupsPersonDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_GROUPS_PERSON')")
    public void delete(GroupsPersonDTO.Delete request) {
        final List<GroupsPerson> groupsPersons = groupsPersonDAO.findAllById(request.getIds());

        groupsPersonDAO.deleteAll(groupsPersons);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_GROUPS_PERSON')")
    public TotalResponse<GroupsPersonDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(groupsPersonDAO, criteria, groupsPerson -> modelMapper.map(groupsPerson, GroupsPersonDTO.Info.class));
    }

    private GroupsPersonDTO.Info save(GroupsPerson groupsPerson) {
        final GroupsPerson saved = groupsPersonDAO.saveAndFlush(groupsPerson);
        return modelMapper.map(saved, GroupsPersonDTO.Info.class);
    }
}
