package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.DataType;
import lombok.*;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("SELECT * FROM TBL_CNTR_CONTRACT_DETAIL_VALUE_AUD")
public class ContractDetailValueAudit extends BaseEntity {

    @EmbeddedId
    private AuditId auditId;

    @Column(name = "REVTYPE")
    private Long revType;

    @NotEmpty
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @NotEmpty
    @Column(name = "C_KEY", nullable = false)
    private String key;

    @NotEmpty
    @Column(name = "C_TITLE", nullable = false)
    private String title;

    @NotNull
    @Column(name = "N_TYPE", nullable = false)
    private DataType type;

    @Column(name = "C_REFERENCE")
    private String reference;

    @Column(name = "B_REQUIRED", nullable = false)
    private Boolean required;

    @Column(name = "C_VALUE")
    private String value;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_UNIT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailValueAudit2unitByUnitId"))
    private Unit unit;

    @Column(name = "F_UNIT_ID")
    private Long unitId;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailValueAudit2contractDetailByContractDetailId"))
    private ContractDetail2 contractDetail;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_ID", nullable = false)
    private Long contractDetailId;
}
