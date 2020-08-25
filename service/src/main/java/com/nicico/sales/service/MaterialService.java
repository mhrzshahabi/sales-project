package com.nicico.sales.service;

import com.nicico.sales.dto.MaterialDTO;
import com.nicico.sales.iservice.IMaterialService;
import com.nicico.sales.model.entities.base.Material;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class MaterialService extends GenericService<Material, Long, MaterialDTO.Create, MaterialDTO.Info, MaterialDTO.Update, MaterialDTO.Delete> implements IMaterialService {
}
