package com.nicico.sales.iservice;

import com.nicico.sales.dto.AccDepartmentDTO;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.model.entities.base.AccDepartment;

import java.util.List;

public interface IAccDepartmentService {

    List<AccDepartmentDTO.Info> list();
}
