package com.nicico.sales.iservice.report;

import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.report.Report;
import com.nicico.sales.model.enumeration.ReportSource;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

public interface IReportService extends IGenericService<Report, Long, ReportDTO.Create, ReportDTO.Info, ReportDTO.Update, ReportDTO.Delete> {

    List<ReportDTO.SourceData> getSourceData(ReportSource reportSource);
    List<ReportDTO.FieldData> getSourceFields(ReportSource reportSource, String source);
    ReportDTO.Info create(List<MultipartFile> files, String fileMetaData, String request) throws IOException, IllegalAccessException, NoSuchFieldException, InvocationTargetException;

}
