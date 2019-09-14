package com.nicico.sales.iservice;

import com.nicico.sales.model.entities.base.myModel.ReportDetails;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface IGetReportService {

    List<ReportDetails> getMoveInfo(String date);

  /*  List<Object[]> calInit(String date, Long gpid, Long value);

  Long calInputOutputSum(String date, Long gpid);



    void calLast();*/

}
