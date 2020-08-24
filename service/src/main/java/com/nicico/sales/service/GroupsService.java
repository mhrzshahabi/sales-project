package com.nicico.sales.service;

import com.nicico.sales.dto.GroupsDTO;
import com.nicico.sales.iservice.IGroupsService;
import com.nicico.sales.model.entities.base.Groups;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class GroupsService extends GenericService<Groups, Long, GroupsDTO.Create, GroupsDTO.Info, GroupsDTO.Update, GroupsDTO.Delete> implements IGroupsService {
}
