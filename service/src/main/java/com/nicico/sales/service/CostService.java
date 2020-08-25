package com.nicico.sales.service;

import com.nicico.sales.dto.CostDTO;
import com.nicico.sales.iservice.ICostService;
import com.nicico.sales.model.entities.base.Cost;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class CostService extends GenericService<Cost, Long, CostDTO.Create, CostDTO.Info, CostDTO.Update, CostDTO.Delete> implements ICostService {
}
