package com.nicico.sales.model.entities.contract;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("SELECT * FROM TBL_CNTR_CONTRACT_DETAIL_VALUE_AUDIT")
public class ContractDetailValueAudit extends ContractDetailValue {

    @EmbeddedId
    private AuditId auditId;

    @Column(name = "REVTYPE")
    private Long revType;
}