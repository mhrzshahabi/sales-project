package com.nicico.sales.model;

import lombok.EqualsAndHashCode;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = false)
public class TozinSalesId implements Serializable {

    private String customer;
    private String source;
    private String tozinId;
    private String nameKala;
    private Long codeKala;
    private String cardId;
    private String target;
    private String carName;
    private String carNo1;
    private String seller;
    private String isFinal;

}
