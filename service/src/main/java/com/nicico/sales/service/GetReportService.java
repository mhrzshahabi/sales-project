package com.nicico.sales.service;


import com.nicico.sales.iservice.IGetReportService;
import com.nicico.sales.model.entities.base.myModel.PMPTYPE;
import com.nicico.sales.model.entities.base.myModel.ReportInfo;
import com.nicico.sales.repository.MoveDAO;
import com.nicico.sales.repository.PlantMaterialPackTypeDAO;
import com.nicico.sales.repository.ReportInfoDAO;
import com.nicico.sales.repository.projection.IMovement;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class GetReportService implements IGetReportService {

    final MoveDAO moveRepository;
    final PlantMaterialPackTypeDAO plantMaterialPackTypeRepository;
    final ReportInfoDAO reportInfoDAO;

    List<IMovement> movementList = new ArrayList<>();
    List<ReportInfo> reportDetails = new ArrayList<>();

    Long PackType = Long.valueOf(0);

    @Override
    public List<ReportInfo> getMovementInfo(String date, String warehouse) {
        if (reportInfoDAO.IfExistenceAnyObjectInDate(date).size() == 0) {
            movementList = moveRepository.findMovement(date);


            PMPTYPE plantMaterialPackType;
            ArrayList<Integer> solfor = new ArrayList<Integer>(4);
            ArrayList<Integer> kotod = new ArrayList<Integer>(7);
            kotod.add(9);
            kotod.add(10);
            kotod.add(11);
            kotod.add(114);
            kotod.add(129);
            kotod.add(90);
            kotod.add(86);
            solfor.add(2);
            solfor.add(14);
            solfor.add(120);
            solfor.add(121);
            Integer rosobElectrolizAnod = 100;
            Integer maftolMess = 1;
            Integer oksidMolibden = 97;
            // if(infoRepository.movementList.get(0).getTZN_DATE())


            test:
            for (IMovement mm : movementList) {

                boolean t = mm.getPACKNAME().contains("فله") || mm.getPACKNAME().matches("0");
                int gscode = mm.getGDSCODE().intValue();
                boolean l = (gscode == rosobElectrolizAnod || oksidMolibden == gscode);
                boolean k = gscode == maftolMess;
                String materialname = mm.getGDSNAME();

                if (!solfor.contains(gscode)) {
                    if (t) {
                        setPackType(Long.valueOf(1));
                    } else {
                        if (kotod.contains(gscode))
                            setPackType(Long.valueOf(2));

                        else if (l) {
                            setPackType(Long.valueOf(3));
                        } else if (k) {
                            setPackType(Long.valueOf(4));
                        } else continue test;
                    }
                } else continue test;

                ReportInfo reportInfo = new ReportInfo();
                Long plant_id = new Long(0);
                // if plant be meiduk has be maped to sarcheshmeh
                if (mm.getSpi() == 2)
                    plant_id = new Long(1);
                    // mean: these material dont have plant
                else if (l || k)
                    plant_id = new Long(0);
                else plant_id = mm.getSpi();
                plantMaterialPackType = plantMaterialPackTypeRepository.findAllByGDSCODEAndPLANT_IDAndPACK_TYPE(mm.getGDSCODE(), plant_id, getPackType());

                reportInfo.setTznDate(mm.getTZN_DATE());
                reportInfo.setValue(mm.getWazn());

                reportInfo.setPMPTYPE_id(plantMaterialPackType.getP_id());
                if (mm.getCONDITION().substring(0, 4).contains("load")) {
                    reportInfo.setLoadOrUnload(new Long(0));
                } else {
                    reportInfo.setLoadOrUnload(new Long(1));
                }
                reportDetails.add(reportInfo);
                reportInfoDAO.save(reportInfo);

            }
        }

        reportDetails = reportInfoDAO.IfExistenceAnyObjectInDate(date);
        return reportDetails;

    }


    private Long getPackType() {
        return PackType;
    }

    private void setPackType(Long packType) {
        PackType = packType;
    }
}







