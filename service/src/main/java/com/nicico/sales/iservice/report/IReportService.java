package com.nicico.sales.iservice.report;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.report.Report;
import com.nicico.sales.model.enumeration.ReportSource;
import io.minio.errors.*;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

public interface IReportService extends IGenericService<Report, Long, ReportDTO.Create, ReportDTO.Info, ReportDTO.Update, ReportDTO.Delete> {

    ReportDTO.Info checkAccess(String permissionKeyPrefix, String reportIdStr);

    List<ReportDTO.SourceData> getSourceData(ReportSource reportSource);

    List<ReportDTO.FieldData> getSourceFields(ReportSource reportSource, String source);

    TotalResponse<Map<String, Object>> getReportData(Long reportId, String baseUrl, MultiValueMap<String, String> criteria) throws IOException;

    TotalResponse<ReportDTO.InfoWithAccess> searchWithAccess(NICICOCriteria nicicoCriteria);

    ReportDTO.Info create(List<MultipartFile> files, String fileMetaData, String request) throws IOException;

    ReportDTO.Info update(List<MultipartFile> files, String fileMetaData, String request) throws IOException, IllegalAccessException, NoSuchFieldException, InvocationTargetException;

    Class<?> getReturnType(ReportDTO.Info report);
}
