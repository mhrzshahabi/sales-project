package com.nicico.sales.model;

import lombok.EqualsAndHashCode;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = false)
public class TozinSalesId implements Serializable {

    private Long pId;
    private String cardId;
    private String carNo1;
    private String carName;
    private String customer;
    private String seller;
    private String tozinPlantId;
    private Long codeKala;
    private String nameKala;
    private String source;
    private String target;
    private String isFinal;

}
