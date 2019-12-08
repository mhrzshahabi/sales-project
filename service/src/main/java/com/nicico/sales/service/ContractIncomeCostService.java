package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import com.nicico.sales.iservice.IContractIncomeCostService;
import com.nicico.sales.model.entities.base.ContractIncomeCost;
import com.nicico.sales.repository.ContractIncomeCostDAO;
import com.nicico.sales.util.ReportBuilder;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractIncomeCostService implements IContractIncomeCostService {

    private final ContractIncomeCostDAO contractIncomeCostDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_CONTRACT_INCOME_COST')")
    public ContractIncomeCostDTO.Info get(Long id) {
        final Optional<ContractIncomeCost> slById = contractIncomeCostDAO.findById(id);
        final ContractIncomeCost contractIncomeCost = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractIncomeCostNotFound));

        return modelMapper.map(contractIncomeCost, ContractIncomeCostDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CONTRACT_INCOME_COST')")
    public List<ContractIncomeCostDTO.Info> list() {
        final List<ContractIncomeCost> slAll = contractIncomeCostDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContractIncomeCostDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_CONTRACT_INCOME_COST')")
    public ContractIncomeCostDTO.Info create(ContractIncomeCostDTO.Create request) {
        final ContractIncomeCost contractIncomeCost = modelMapper.map(request, ContractIncomeCost.class);

        return save(contractIncomeCost);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_CONTRACT_INCOME_COST')")
    public ContractIncomeCostDTO.Info update(Long id, ContractIncomeCostDTO.Update request) {
        final Optional<ContractIncomeCost> slById = contractIncomeCostDAO.findById(id);
        final ContractIncomeCost contractIncomeCost = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractIncomeCostNotFound));

        ContractIncomeCost updating = new ContractIncomeCost();
        modelMapper.map(contractIncomeCost, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CONTRACT_INCOME_COST')")
    public void delete(Long id) {
        contractIncomeCostDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CONTRACT_INCOME_COST')")
    public void delete(ContractIncomeCostDTO.Delete request) {
        final List<ContractIncomeCost> contractIncomeCosts = contractIncomeCostDAO.findAllById(request.getIds());

        contractIncomeCostDAO.deleteAll(contractIncomeCosts);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CONTRACT_INCOME_COST')")
    public SearchDTO.SearchRs<ContractIncomeCostDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(contractIncomeCostDAO, request, contractIncomeCost -> modelMapper.map(contractIncomeCost, ContractIncomeCostDTO.Info.class));
    }

    private ContractIncomeCostDTO.Info save(ContractIncomeCost contractIncomeCost) {
        final ContractIncomeCost saved = contractIncomeCostDAO.saveAndFlush(contractIncomeCost);
        return modelMapper.map(saved, ContractIncomeCostDTO.Info.class);
    }

    @Override
    public void pdfFx(List<ContractIncomeCostDTO.Info> myList, ArrayList<String> columns, ArrayList<String> fields, String type, HttpServletResponse httpServletResponse) throws JRException, IOException {
        JasperDesign jasperDesign = ReportBuilder.getPageTemplateDesign(getClass().getResourceAsStream("/reports/report.jrxml"), columns, fields);
        JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, new JRBeanCollectionDataSource(myList));
        switch (type) {
            case "pdf":
                httpServletResponse.setContentType("application/x-pdf");
                httpServletResponse.setHeader("Content-disposition", "inline; filename=report.pdf");
                JasperExportManager.exportReportToPdfStream(jasperPrint, httpServletResponse.getOutputStream());
                break;
            case "excel":
                httpServletResponse.setContentType("application/vnd.ms-excel");
                httpServletResponse.setHeader("Content-disposition", "inline; filename=report.xls");
                JRXlsxExporter xlsxExporter = new JRXlsxExporter(DefaultJasperReportsContext.getInstance());
                xlsxExporter.setExporterInput(new SimpleExporterInput(jasperPrint));
                xlsxExporter.setExporterOutput(new SimpleOutputStreamExporterOutput(httpServletResponse.getOutputStream()));
                SimpleXlsxReportConfiguration reportConfigXls = new SimpleXlsxReportConfiguration();
                reportConfigXls.setSheetNames(new String[]{"Data"});
                xlsxExporter.setConfiguration(reportConfigXls);
                xlsxExporter.exportReport();
                httpServletResponse.getOutputStream().flush();
                break;
            case "html":
                httpServletResponse.setContentType("text/html");
                httpServletResponse.setCharacterEncoding("UTF-8");
                HtmlExporter htmlExporter = new HtmlExporter(DefaultJasperReportsContext.getInstance());
                htmlExporter.setExporterInput(new SimpleExporterInput(jasperPrint));
                htmlExporter.setExporterOutput(new SimpleHtmlExporterOutput(httpServletResponse.getWriter()));
                htmlExporter.exportReport();
                break;
        }
    }
}
