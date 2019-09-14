package com.nicico.sales.iservice;

import com.nicico.sales.dto.ResponseListDTO;
import org.springframework.stereotype.Service;

@Service
public interface ICalculateService {

   // ResponseList calImportExportForMonnAndYear(Map<Integer, Integer> in, Map<Integer, Integer> out, Integer i, String date);
    ResponseListDTO calImportExportForMonnAndYear(Integer in, Integer out, Integer i, String date);
   // void checkDate();

    //int calculteAmountImportMon(String date ,Long i);
    //int calculteAmountExportMon(String date ,Long i);
    // Long calInputOutputSum(String date,Long gpid, int loadorunload);
}
