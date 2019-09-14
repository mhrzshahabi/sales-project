package com.nicico.sales.service;

import com.nicico.sales.dto.DateEventValuesDTO;
import com.nicico.sales.dto.ResponseListDTO;
import com.nicico.sales.iservice.ICalculateService;
import com.nicico.sales.iservice.IDateEventService;
import com.nicico.sales.model.entities.base.myModel.PMPTYPE;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import com.nicico.sales.repository.PlantMaterialPackTypeDAO;
import com.nicico.sales.repository.WholeDtoDAO;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalculateService implements ICalculateService {

    private final WholeDtoDAO wholeDtoRepository;
    private final IDateEventService dateEvent ;
    private final PlantMaterialPackTypeDAO pmptyperepository;


    public CalculateService(WholeDtoDAO wholeDtoRepository, IDateEventService dateEvent, PlantMaterialPackTypeDAO pmptyperepository) {
        this.wholeDtoRepository = wholeDtoRepository;
        this.dateEvent = dateEvent;
        this.pmptyperepository = pmptyperepository;
    }

    @Override
    public ResponseListDTO calImportExportForMonnAndYear(Integer in, Integer out, Integer i, String date) {
        Integer initvaluesDay;
        Integer initvaluesMoon = 0;
        Integer initvaluesYear = 0;
        Integer importvaluesYear = 0;
        Integer exportvaluesYear = 0;
        Integer importvaluesMoon = 0;
        Integer exportvaluesMoon = 0;

        ResponseListDTO responseList = new ResponseListDTO();
        PMPTYPE pmptype = pmptyperepository.findAllByP_id(new Long(i));

        //start cal import export values
        DateEventValuesDTO dateEventValues = dateEvent.calDateValues(date);
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
        else initvaluesDay = 0;
        //   initvaluesMoon = wholeDtoRepository.findAmountMoon(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), experMoon).getAmountFirstMon();
        if (wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforMonth()) != null)
            initvaluesMoon = wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforMonth()).getAmountFirstMon();
        else initvaluesMoon = 0;
        // initvaluesYear = wholeDtoRepository.findAmountYear(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), experYear).getAmountFirstSal();
        if (wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforeYear()) != null)
            initvaluesYear = wholeDtoRepository.findAmount(pmptype.getGDSNAME(), pmptype.getPACKNAME(), pmptype.getNAMEFA(), dateEventValues.getBeforeYear()).getAmountFirstSal();
        else initvaluesYear = 0;
        //end
        //cal all amout last day, i want to negotiate

        //int thisInputValue = in.get(i);
        int thisInputValue = in;
       // int thisOutputValue = out.get(i);
        int thisOutputValue = out;
        Integer amoutDay = Math.abs(initvaluesDay + thisInputValue - thisOutputValue);
        //end
        responseList.setAmountFirstSal(initvaluesYear);
        responseList.setAmountFirstMon(initvaluesMoon);
        responseList.setAmountFirstDay(initvaluesDay);
        responseList.setAmountImportMon(importvaluesMoon + thisInputValue);
        responseList.setAmountExportMon(exportvaluesMoon + thisOutputValue);
        responseList.setAmountImportSal(importvaluesYear + thisInputValue);
        responseList.setAmountExportSal(exportvaluesYear + thisOutputValue);
        responseList.setAmountDay(amoutDay);
        responseList.setReviseSal(0);
        responseList.setAmountReviseDay(0);
        responseList.setAmountReviseMon(0);
        responseList.setAa(0);
        return responseList;

    }
}



