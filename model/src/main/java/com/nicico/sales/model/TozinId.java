package com.nicico.sales.model;

import lombok.EqualsAndHashCode;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = false)
public class TozinId implements Serializable {

    private String target;
    private String cardId;
    private Long pId;
    private String source;
    private String tozinPlantId;
    private String nameKala;
    private Long codeKala;
    private Long materialId;

}
