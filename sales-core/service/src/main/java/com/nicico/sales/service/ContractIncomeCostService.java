package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
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
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@RequiredArgsConstructor
@Service
public class ContractIncomeCostService implements IContractIncomeCostService {

    private final ContractIncomeCostDAO contractIncomeCostDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public ContractIncomeCostDTO.Info get(Long id) {
        final Optional<ContractIncomeCost> slById = contractIncomeCostDAO.findById(id);
        final ContractIncomeCost contractIncomeCost = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractIncomeCostNotFound));

        return modelMapper.map(contractIncomeCost, ContractIncomeCostDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<ContractIncomeCostDTO.Info> list() {
        final List<ContractIncomeCost> slAll = contractIncomeCostDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContractIncomeCostDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    public ContractIncomeCostDTO.Info create(ContractIncomeCostDTO.Create request) {
        final ContractIncomeCost contractIncomeCost = modelMapper.map(request, ContractIncomeCost.class);

        return save(contractIncomeCost);
    }

    @Transactional
    @Override
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
    public void delete(Long id) {
        contractIncomeCostDAO.deleteById(id);
    }

    @Transactional
    @Override
    public void delete(ContractIncomeCostDTO.Delete request) {
        final List<ContractIncomeCost> contractIncomeCosts = contractIncomeCostDAO.findAllById(request.getIds());

        contractIncomeCostDAO.deleteAll(contractIncomeCosts);
    }

    @Transactional(readOnly = true)
    @Override
    public SearchDTO.SearchRs<ContractIncomeCostDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(contractIncomeCostDAO, request, contractIncomeCost -> modelMapper.map(contractIncomeCost, ContractIncomeCostDTO.Info.class));
    }

    // ------------------------------

    private ContractIncomeCostDTO.Info save(ContractIncomeCost contractIncomeCost) {
        final ContractIncomeCost saved = contractIncomeCostDAO.saveAndFlush(contractIncomeCost);
        return modelMapper.map(saved, ContractIncomeCostDTO.Info.class);
    }

    @Override
    public void pdfFx(List<ContractIncomeCostDTO.Info> myList, ArrayList<String> columns) throws JRException {
        JasperDesign jasperDesign = ReportBuilder.getPageTemplateDesign("report.jrxml", columns);
        JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, new JRBeanCollectionDataSource(myList));
        JasperExportManager.exportReportToPdfFile(jasperPrint, "output.pdf");
    }
}
