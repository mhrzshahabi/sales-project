package com.nicico.sales.model;

import lombok.EqualsAndHashCode;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = false)
public class CathodeListId implements Serializable {
    private String storeId;
    private String tozinId;
    private String productId;
    private String productLabel;
    private Long wazn;
    private Long sheetNumber;
    private Long packingTypeId;
    private Long gdsCode;
}
