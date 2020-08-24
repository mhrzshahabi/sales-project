package com.nicico.sales.service;

import com.nicico.sales.dto.GroupsPersonDTO;
import com.nicico.sales.iservice.IGroupsPersonService;
import com.nicico.sales.model.entities.base.GroupsPerson;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class GroupsPersonService extends GenericService<GroupsPerson, Long, GroupsPersonDTO.Create, GroupsPersonDTO.Info, GroupsPersonDTO.Update, GroupsPersonDTO.Delete> implements IGroupsPersonService {
}
