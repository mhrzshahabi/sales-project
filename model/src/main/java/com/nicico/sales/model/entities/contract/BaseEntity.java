package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.enumeration.EStatus;

import javax.persistence.Column;

public class BaseEntity extends Auditable {

    @Column(name = "B_EDITABLE")
    private Boolean editable;

    @Column(name = "N_E_STATUS")
    private EStatus eStatus;
}
