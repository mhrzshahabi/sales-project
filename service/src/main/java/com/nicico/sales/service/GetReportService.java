package com.nicico.sales.service;


import com.nicico.sales.iservice.IGetReportService;
import com.nicico.sales.model.entities.base.myModel.PMPTYPE;
import com.nicico.sales.model.entities.base.myModel.ReportDetails;
import com.nicico.sales.repository.MoveDAO;
import com.nicico.sales.repository.PlantMaterialPackTypeDAO;
import com.nicico.sales.repository.ReportInfoDAO;
import com.nicico.sales.repository.projection.IMovement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GetReportService implements IGetReportService {

    @Autowired
    MoveDAO moveRepository;
   /* @Autowired
    Sales salesRepository;*/
    @Autowired
   PlantMaterialPackTypeDAO plantMaterialPackTypeRepository;
    @Autowired
    ReportInfoDAO infoRepository;



    List<IMovement> movementList = new ArrayList<>();
    List<ReportDetails> reportDetails = new ArrayList<>();

    Long PackType = Long.valueOf(0);


    /*@PostConstruct
    public void initialize() {
       calInit("1398/01/26", new Long(1), new Long(2000));
    }*/

    @Override
    public List<ReportDetails> getMoveInfo(String date) {

        movementList = moveRepository.findMovement(date);


        //ArrayList<Movement> movements= movementList;

        PMPTYPE plantMaterialPackType = new PMPTYPE();
        ArrayList<Integer> solfor = new ArrayList<Integer>(4);
        ArrayList<Integer> kotod = new ArrayList<Integer>(5);
        kotod.add(9);
        kotod.add(10);
        kotod.add(11);
        kotod.add(114);
        kotod.add(129);
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

            ReportDetails reportInfo = new ReportDetails();
            Long plant_id = new Long(0);
            if (mm.getSpi() == 2)
                plant_id = new Long(1);
            else if (l || k)
                plant_id = new Long(0);
            else plant_id = mm.getSpi();
            plantMaterialPackType = plantMaterialPackTypeRepository.findAllByGDSCODEAndPLANT_IDAndPACK_TYPE(mm.getGDSCODE(), plant_id, getPackType());

            reportInfo.setTzn_date(mm.getTZN_DATE());
            reportInfo.setValue(mm.getWazn());

            reportInfo.setPMPTYPE_id(plantMaterialPackType.getP_id());
            if (mm.getCONDITION().substring(0,4).contains("load")) {
                reportInfo.setLoadOrUnload(new Long(0));
                //   calInput(mm.getTZN_DATE(), plantMaterialPackType.getP_id(), mm.getWazn());
            } else {
                reportInfo.setLoadOrUnload(new Long(1));
                //  calOutput(mm.getTZN_DATE(), plantMaterialPackType.getP_id(), mm.getWazn());
            }
            reportDetails.add(reportInfo);
            infoRepository.save(reportInfo);

        }
        //calLast();
        return reportDetails;

    }


    public Long getPackType() {
        return PackType;
    }

    public void setPackType(Long packType) {
        PackType = packType;
    }


}







