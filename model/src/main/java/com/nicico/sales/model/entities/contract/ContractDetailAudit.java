package com.nicico.sales.model.entities.contract;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import java.io.Serializable;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("SELECT * FROM TBL_CNTR_CONTRACT_DETAIL_AUDIT")
public class ContractDetailAudit extends ContractDetail {

    @EmbeddedId
    private ContractDetailAudit.ContractDetailAuditId auditId;

    @Column(name = "REVTYPE")
    private Long revType;

    @Getter
    @Embeddable
    @EqualsAndHashCode(callSuper = false)
    public static class ContractDetailAuditId implements Serializable {

        @Column(name = "ID")
        private Long id;

        @Column(name = "REV")
        private Long rev;
    }
}