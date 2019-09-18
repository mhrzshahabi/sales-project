package com.nicico.sales.service;

import com.nicico.sales.dto.DateEventValuesDTO;
import com.nicico.sales.dto.ResponseListDTO;
import com.nicico.sales.iservice.ICalculateService;
import com.nicico.sales.iservice.IDateCalculateService;
import com.nicico.sales.iservice.IDateEventService;
import com.nicico.sales.model.entities.base.myModel.PMPTYPE;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import com.nicico.sales.repository.PlantMaterialPackTypeDAO;
import com.nicico.sales.repository.WholeDtoDAO;

import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.List;

@Service
public class CalculateService implements ICalculateService {

    private final WholeDtoDAO wholeDtoRepository;
    private final IDateCalculateService dateCalculateService;
    private final PlantMaterialPackTypeDAO pmptyperepository;


    public CalculateService(WholeDtoDAO wholeDtoRepository,  IDateCalculateService dateCalculateService, PlantMaterialPackTypeDAO pmptyperepository) {
        this.wholeDtoRepository = wholeDtoRepository;
        this.dateCalculateService = dateCalculateService;
        this.pmptyperepository = pmptyperepository;
    }

    @Override
    public ResponseListDTO calImportExportForMonnAndYear(Double in, Double out, Double i, String date) throws ParseException {
        Double initvaluesDay;
        Double initvaluesMoon = 0.0;
        Double initvaluesYear =  0.0;
        Double importvaluesYear =  0.0;
        Double exportvaluesYear =  0.0;
        Double importvaluesMoon =  0.0;
        Double exportvaluesMoon =  0.0;

        ResponseListDTO responseList = new ResponseListDTO();
        PMPTYPE pmptype = pmptyperepository.findAllByP_id(i.longValue());

        //start cal import export values

        DateEventValuesDTO dateEventValues = dateCalculateService.getEveryDateYouWant(date);
        String firstOfMoonDate = dateEventValues.getFirstOfMonth();
        String firstOfYearDate = dateEventValues.getFirstOfYear();
        List<WholeDto> searchMoonValueList =
                wholeDtoRepository.findMonthAndValueBetweenTwoDay(firstOfMoonDate, date, pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA());
        List<WholeDto> searchYearsValueList =
                wholeDtoRepository.findMonthAndValueBetweenTwoDay(firstOfYearDate, date, pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA());
        for (WholeDto wh : searchMoonValueList) {
            importvaluesMoon += wh.getAmountImportDay();
            exportvaluesMoon += wh.getAmountExportDay();

        }
        for (WholeDto wh : searchYearsValueList) {
            importvaluesYear += wh.getAmountImportDay();
            exportvaluesYear += wh.getAmountExportDay();
        }
        //end
        boolean k = false;
        //start cal init value
        if (wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getYeasterday()) != null)
            initvaluesDay = wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getYeasterday()).getAmountDay();
        else initvaluesDay = 0.0;
        //   initvaluesMoon = wholeDtoRepository.findAmountMoon(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), experMoon).getAmountFirstMon();
        if (wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforMonth()) != null)
            initvaluesMoon = wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforMonth()).getAmountDay();
        else initvaluesMoon = 0.0;
        // initvaluesYear = wholeDtoRepository.findAmountYear(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), experYear).getAmountFirstSal();
        if (wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforeYear()) != null)
            initvaluesYear = wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforeYear()).getAmountDay();
        else initvaluesYear =0.0;
        //end
        //cal all amout last day, i want to negotiate

        //int thisInputValue = in.get(i);
        Double thisInputValue = in;
        // int thisOutputValue = out.get(i);
        Double thisOutputValue = out;
        Double amoutDay = Math.abs(initvaluesDay + thisInputValue - thisOutputValue);
        //end
        responseList.setAmountFirstSal(initvaluesYear);
        responseList.setAmountFirstMon(initvaluesMoon);
        responseList.setAmountFirstDay(initvaluesDay);
        responseList.setAmountImportMon(importvaluesMoon + thisInputValue);
        responseList.setAmountExportMon(exportvaluesMoon + thisOutputValue);
        responseList.setAmountImportSal(importvaluesYear + thisInputValue);
        responseList.setAmountExportSal(exportvaluesYear + thisOutputValue);
        responseList.setAmountDay(amoutDay);
        responseList.setReviseSal(0.0);
        responseList.setAmountReviseDay(0.0);
        responseList.setAmountReviseMon(0.0);
        responseList.setAa(0.0);
        return responseList;

    }
}



