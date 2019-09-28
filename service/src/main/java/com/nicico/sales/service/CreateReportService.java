package com.nicico.sales.service;

import com.nicico.sales.dto.ResponseListDTO;
import com.nicico.sales.iservice.ICalculateService;
import com.nicico.sales.iservice.ICreateReportService;
import com.nicico.sales.iservice.IGetReportService;
import com.nicico.sales.model.entities.base.myModel.ColumnDto;
import com.nicico.sales.model.entities.base.myModel.ReportDto;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import com.nicico.sales.repository.ReportInfoDAO;
import com.nicico.sales.repository.WholeDtoDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Slf4j
@Service
public class CreateReportService implements ICreateReportService {

    private final IGetReportService getReport;
    private final ReportInfoDAO reportInfoRepository;
    private final WholeDtoDAO wholeDtoRepository;
    private final ICalculateService calculateService;
    private Map<Long, Double> pidinputValueMAp = new HashMap<>();
    private Map<Long, Double> pidoutputValueMAp = new HashMap<>();
    private Map<Double, Double> resultinputValueMap = new HashMap<>();
    private Map<Double, Double> resultoutputValueMap = new HashMap<>();
    private Map<Double, Double> inpulongList = new HashMap<Double, Double>();
    private Map<Double, Double> outputlongList = new HashMap<>();

    public List<WholeDto> createReport(String date, String warehouse) {

        getReport.getMovementInfo(date,warehouse);

        List<WholeDto> wholeDtoList = wholeDtoRepository.findAllByToDay(date);
        if (wholeDtoList.size() != 0) return wholeDtoList;
        else {

            Map<String, Object> parametersMap = new HashMap<>();
            parametersMap.put("logo_nicico", "C:\\upload\\report-logo\\nicico-logo.png");

            List<ReportDto> list = reportInfoRepository.getAllInfoReport(date);
            for (int k = 0; k < list.size(); k++) {
                ReportDto reportDto = list.get(k);
//load=0 means output, unload=1 means input
                if (reportDto.getLoadOrUnload() == 1) {
                    Double index = Double.valueOf(reportDto.getPMPTYPE_id().intValue());
                    if (inpulongList.isEmpty() || inpulongList.size() < index)
                        inpulongList.put(index - 1, 0.0);
                    Double newValue = inpulongList.get(index - 1) + reportDto.getValue().intValue();
                    //  inpulongList.set(index, newValue);
                    inpulongList.put(index - 1, newValue);
                    pidinputValueMAp.put(reportDto.getPMPTYPE_id(), newValue);
                    // List<Long> longValuesOfOnePid = pidinputValueMAp.entrySet().iterator().next().getValue();
                   /* inputValuess = inpulongList.stream().mapToInt(i -> i.intValue())
                            .sum();*/
                    resultinputValueMap.put(Double.valueOf(reportDto.getPMPTYPE_id()), newValue);
                    //  reportDto.setAmountImportDay(inputValuess);
                } else if (reportDto.getLoadOrUnload() == 0) {
                    Double in = Double.valueOf(reportDto.getPMPTYPE_id());
                    if (outputlongList.isEmpty() || outputlongList.size() < in)
                        outputlongList.put(in - 1, 0.0);
                    Double newV = outputlongList.get(in - 1) + reportDto.getValue();

                    outputlongList.put(in - 1, newV);
                    // outputValuess = outputlongList.get(reportDto.getPMPTYPE_id().intValue()).intValue() + reportDto.getValue().intValue();
                    pidoutputValueMAp.put(reportDto.getPMPTYPE_id(), newV);
                    // List<Long> longValuesOfOnePid = pidoutputValueMAp.entrySet().iterator().next().getValue();

                    /*outputValuess = outputlongList.stream().mapToInt(i -> i.intValue())
                            .sum();*/
                    resultoutputValueMap.put(Double.valueOf(reportDto.getPMPTYPE_id()), newV);
                    //reportDto.setAmountExportDay(outputValuess);
                }
            }

            for (Double i = 1.0; i <= 27.0; i++) {
                ColumnDto columnDto = reportInfoRepository.getsearchpmpttype(i.longValue());
                ColumnDto baseColumnDto = reportInfoRepository.getPMPTYpe(i.longValue());
                WholeDto wholeDto = new WholeDto();
                //calculate to count total
                if (i == 3 || i == 6 || i == 11 || i == 12 || i == 17 || i == 18) {
                    Double amountImportDay = 0.0;
                    Double amountExportDay = 0.0;
                    Double amountDay = 0.0;
                    Double amountFirstDay = 0.0;
                    Double amountImportMon = 0.0;
                    Double amountFirstMon = 0.0;
                    Double amountExportMon = 0.0;
                    Double amountFirstSal = 0.0;
                    Double amountImportSal = 0.0;
                    Double amountExportSal = 0.0;
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
                    Double inputValueMap = 0.0;
                    Double outputValueMap = 0.0;

                    if (java.util.Optional.ofNullable(columnDto).isPresent()) {
                        if (resultinputValueMap.containsKey(i)) inputValueMap = resultinputValueMap.get(i);
                        wholeDto.setAmountImportDay(inputValueMap);
                        if (resultoutputValueMap.containsKey(i)) outputValueMap = resultoutputValueMap.get(i);
                        wholeDto.setAmountExportDay(outputValueMap);
                    } else {
                        wholeDto.setAmountImportDay(0.0);
                        wholeDto.setAmountExportDay(0.0);

                    }
                    ResponseListDTO responseList = null;
                    try {
                        responseList = calculateService.calImportExportForMonnAndYear(inputValueMap, inputValueMap, i, date);
                    } catch (ParseException e) {
                        log.error(e + "this date:" + date);
                    }
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
                wholeDto.setAmountReviseDay(0.0);
                wholeDto.setAmountReviseMon(0.0);
                wholeDto.setAmountReviseSal(0.0);
                wholeDto.setReviseSal(0.0);
                wholeDto.setAa(0.0);
                /*i don't have fit knowledage to calculate them */
                wholeDto.setDescp(baseColumnDto.getGDSNAME());
                wholeDto.setPlant(baseColumnDto.getNAMEFA());
                wholeDto.setPackingType(baseColumnDto.getPACKNAME());
                wholeDto.setWarehouse("بندرعباس");
                wholeDto.setToDay(date);
                wholeDtoRepository.save(wholeDto);
                wholeDtoList.add(wholeDto);

            }

            return wholeDtoList;

            //end of calculate wholedtoList

        }

    }
}



