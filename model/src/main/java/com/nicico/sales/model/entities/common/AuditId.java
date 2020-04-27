package com.nicico.sales.model.entities.common;

import lombok.EqualsAndHashCode;
import lombok.Getter;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Getter
@Embeddable
@EqualsAndHashCode(callSuper = false)
public class AuditId implements Serializable {

    @Column(name = "ID")
    private Long id;

    @Column(name = "REV")
    private Long rev;
}
