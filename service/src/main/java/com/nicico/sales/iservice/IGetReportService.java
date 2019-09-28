package com.nicico.sales.iservice;

import com.nicico.sales.model.entities.base.myModel.ReportInfo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface IGetReportService {
    List<ReportInfo> getMovementInfo(String date, String warehouse);
}
