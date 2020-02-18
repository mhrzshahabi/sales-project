package com.nicico.sales.model;

import lombok.EqualsAndHashCode;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = false)
public class TozinId implements Serializable {

    private String source;
    private String tozinId;
    private String nameKala;
    private Long codeKala;
    private String target;
    private String cardId;

}
