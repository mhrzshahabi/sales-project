package com.nicico.sales.repository.projection;

import com.nicico.sales.model.entities.base.myModel.Movement;

import org.springframework.data.rest.core.config.*;

@Projection(
        name = "iMovement",
        types = { Movement.class })
public interface IMovement {
    String getCar();


    Long getMATERIAL_ID();


    Long getSpi();
     void setSpi(Long spi);

    Long getTpi();


    Long getGDSCODE();


    String getCONDITION();

    String getTZN_DATE();


    Long getID();

    String getNAMEFA();


    String getSnamefa();


    String getPlant();


    String getSnameen();


    String getGDSNAME();


    Long getWazn();


    Long getTedad();


    String getPACKNAME();


}
