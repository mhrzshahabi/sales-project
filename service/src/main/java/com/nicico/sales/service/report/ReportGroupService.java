package com.nicico.sales.service.report;

import com.nicico.sales.dto.report.ReportGroupDTO;
import com.nicico.sales.iservice.report.IReportGroupService;
import com.nicico.sales.model.entities.report.ReportGroup;
import com.nicico.sales.repository.report.ReportGroupDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ReportGroupService extends GenericService<ReportGroup, Long, ReportGroupDTO.Create, ReportGroupDTO.Info, ReportGroupDTO.Update, ReportGroupDTO.Delete> implements IReportGroupService {

    @Override
    @Transactional(readOnly = true)
    public List<Long> getChilds(Long rootId) {
        List<Long> childs = ((ReportGroupDAO) repository).getAllChilds(rootId);
        return childs;
    }
}
