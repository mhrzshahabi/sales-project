package com.nicico.sales.service;

import com.google.gson.JsonObject;
import com.nicico.copper.common.domain.json.ResultSetConverter;
import com.nicico.sales.dto.ResponseListDTO;
import com.nicico.sales.iservice.ICalculateService;
import com.nicico.sales.iservice.ICreateReportService;
import com.nicico.sales.iservice.IGetReportService;
import com.nicico.sales.model.entities.base.myModel.ColumnDto;
import com.nicico.sales.model.entities.base.myModel.ReportDto;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import com.nicico.sales.repository.MoveDAO;
import com.nicico.sales.repository.ReportInfoDAO;
import com.nicico.sales.repository.WholeDtoDAO;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class CreateReportService implements ICreateReportService {

    private final IGetReportService getReport;
    private final ResultSetConverter resultSetConverter;
    private final ReportInfoDAO reportInfoRepository;
    private final WholeDtoDAO wholeDtoRepository;
    private final ICalculateService calculateService;

    Map<Long, Integer> pidinputValueMAp = new HashMap<>();
    Map<Long, Integer> pidoutputValueMAp = new HashMap<>();
    Map<Integer, Integer> resultinputValueMap = new HashMap<>();
    Map<Integer, Integer> resultoutputValueMap = new HashMap<>();
    Map<Integer, Integer> inpulongList = new HashMap<Integer, Integer>();
    Map<Integer, Integer> outputlongList = new HashMap<>();

    private final MoveDAO moveRepository;
    Long inputValue = new Long(0);

    public CreateReportService(IGetReportService getReport, ResultSetConverter resultSetConverter, ReportInfoDAO reportInfoRepository, WholeDtoDAO wholeDtoRepository, ICalculateService calculateService, MoveDAO moveRepository) {
        this.getReport = getReport;
        this.resultSetConverter = resultSetConverter;
        this.reportInfoRepository = reportInfoRepository;
        this.wholeDtoRepository = wholeDtoRepository;
        this.calculateService = calculateService;
        this.moveRepository = moveRepository;
    }

    public List<WholeDto> createReport(String date, String warehouseNo) {
        List<WholeDto> wholeDtoList = new ArrayList<WholeDto>();

        getReport.getMoveInfo(date);

        wholeDtoList = wholeDtoRepository.findAllByToDay(date);

        if (wholeDtoList.size() != 0) return wholeDtoList;
        else {

            Map<String, Object> parametersMap = new HashMap<String, Object>();
            ArrayList arrayList = new ArrayList();
            parametersMap.put("logo_nicico", "C:\\upload\\report-logo\\nicico-logo.png");

            List<ReportDto> list = reportInfoRepository.getAllInfoReport(date);
            // outputlongList.replaceAll((k, v) -> 0);
            /*for (ReportDto reportDto : list) {*/
            for (int k = 0; k < list.size(); k++) {
                ReportDto reportDto = list.get(k);
//load=0 means output, unload=1 means input
                if (reportDto.getLoadOrUnload() == 1) {
                    int index = reportDto.getPMPTYPE_id().intValue();
                    if (inpulongList.isEmpty() || inpulongList.size() < index)
                        inpulongList.put(index - 1, 0);
                    int newValue = inpulongList.get(index - 1) + reportDto.getValue().intValue();
                    //  inpulongList.set(index, newValue);
                    inpulongList.put(index - 1, newValue);
                    pidinputValueMAp.put(reportDto.getPMPTYPE_id(), newValue);
                    // List<Long> longValuesOfOnePid = pidinputValueMAp.entrySet().iterator().next().getValue();
                   /* inputValuess = inpulongList.stream().mapToInt(i -> i.intValue())
                            .sum();*/
                    resultinputValueMap.put(reportDto.getPMPTYPE_id().intValue(), newValue);
                    //  reportDto.setAmountImportDay(inputValuess);
                } else if (reportDto.getLoadOrUnload() == 0) {
                    int in = reportDto.getPMPTYPE_id().intValue();
                    if (outputlongList.isEmpty() || outputlongList.size() < in)
                        outputlongList.put(in - 1, 0);
                    int newV = outputlongList.get(in - 1).intValue() + reportDto.getValue().intValue();

                    outputlongList.put(in - 1, newV);
                    // outputValuess = outputlongList.get(reportDto.getPMPTYPE_id().intValue()).intValue() + reportDto.getValue().intValue();
                    pidoutputValueMAp.put(reportDto.getPMPTYPE_id(), newV);
                    // List<Long> longValuesOfOnePid = pidoutputValueMAp.entrySet().iterator().next().getValue();

                    /*outputValuess = outputlongList.stream().mapToInt(i -> i.intValue())
                            .sum();*/
                    resultoutputValueMap.put(reportDto.getPMPTYPE_id().intValue(), newV);
                    //reportDto.setAmountExportDay(outputValuess);
                }
            }

            for (int i = 1; i <= 24; i++) {
                ColumnDto columnDto = reportInfoRepository.getsearchpmpttype(Long.valueOf(i));
                ColumnDto baseColumnDto = reportInfoRepository.getPMPTYpe(Long.valueOf(i));
                WholeDto wholeDto = new WholeDto();
                //calculate to count total
                if (i == 3 || i == 6 || i == 11 || i == 12 || i == 17 || i == 18) {
                    Integer amountImportDay = 0;
                    Integer amountExportDay = 0;
                    Integer amountDay = 0;
                    Integer amountFirstDay = 0;
                    Integer amountImportMon = 0;
                    Integer amountFirstMon = 0;
                    Integer amountExportMon = 0;
                    Integer amountFirstSal = 0;
                    Integer amountImportSal = 0;
                    Integer amountExportSal = 0;
                    List<WholeDto> caltotalvalue = wholeDtoRepository.findAllByTzn_dateAnAndPMPTYPE_id(date, baseColumnDto.getGDSNAME(), baseColumnDto.getPACKNAME());
                    for (WholeDto everyvalues : caltotalvalue) {
                        amountImportDay += everyvalues.getAmountImportDay();
                        amountExportDay += everyvalues.getAmountExportDay();
                        amountDay += everyvalues.getAmountDay();
                        amountFirstDay += everyvalues.getAmountFirstDay();
                        amountFirstMon += everyvalues.getAmountFirstMon();
                        amountImportMon += everyvalues.getAmountImportMon();
                        amountExportMon += everyvalues.getAmountExportMon();
                        amountFirstSal += everyvalues.getAmountFirstSal();
                        amountImportSal += everyvalues.getAmountImportSal();
                        amountExportSal += everyvalues.getAmountExportSal();

                    }
                    wholeDto.setAmountImportDay(amountImportDay);
                    wholeDto.setAmountExportDay(amountExportDay);
                    wholeDto.setAmountDay(amountDay);
                    wholeDto.setAmountFirstDay(amountFirstDay);
                    wholeDto.setAmountFirstMon(amountFirstMon);
                    wholeDto.setAmountImportMon(amountImportMon);
                    wholeDto.setAmountExportMon(amountExportMon);
                    wholeDto.setAmountFirstSal(amountFirstSal);
                    wholeDto.setAmountImportSal(amountImportSal);
                    wholeDto.setAmountExportSal(amountExportSal);

                } else {
                    Integer inputValueMap = 0;
                    Integer outputValueMap = 0;

                    if (java.util.Optional.ofNullable(columnDto).isPresent()) {
                        if (resultinputValueMap.containsKey(i)) inputValueMap = resultinputValueMap.get(i);
                        wholeDto.setAmountImportDay(inputValueMap);
                        if (resultoutputValueMap.containsKey(i)) outputValueMap = resultoutputValueMap.get(i);
                        wholeDto.setAmountExportDay(outputValueMap);
                    } else {
                        wholeDto.setAmountImportDay(0);
                        wholeDto.setAmountExportDay(0);

                    }
                    ResponseListDTO responseList = calculateService.calImportExportForMonnAndYear(inputValueMap, inputValueMap, i, date);
                    wholeDto.setAmountDay(responseList.getAmountDay());
                    wholeDto.setAmountFirstDay(responseList.getAmountFirstDay());
                    wholeDto.setAmountFirstMon(responseList.getAmountFirstMon());
                    wholeDto.setAmountImportMon(responseList.getAmountImportMon());
                    wholeDto.setAmountExportMon(responseList.getAmountExportMon());
                    wholeDto.setAmountFirstSal(responseList.getAmountFirstSal());
                    wholeDto.setAmountImportSal(responseList.getAmountImportSal());
                    wholeDto.setAmountExportSal(responseList.getAmountExportSal());
                }
                /*i don't have fit knowledage to calculate them */
                wholeDto.setAmountReviseDay(0);
                wholeDto.setAmountReviseMon(0);
                wholeDto.setAmountReviseSal(0);
                wholeDto.setReviseSal(0);
                wholeDto.setAa(0);
                /*i don't have fit knowledage to calculate them */
                wholeDto.setDescp(baseColumnDto.getGDSNAME());
                wholeDto.setPlant(baseColumnDto.getNAMEFA());
                wholeDto.setPackingType(baseColumnDto.getPACKNAME());
                wholeDto.setWarehouseNo("بندرعباس");
                wholeDto.setToDay(date);
                wholeDtoRepository.save(wholeDto);
                wholeDtoList.add(wholeDto);

            }

            return wholeDtoList;

            //end of calculate wholedtoList


        }



    }
}



