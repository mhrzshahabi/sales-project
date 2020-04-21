package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.ContractDetail;
import com.nicico.sales.model.entities.base.Material;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("SELECT * FROM TBL_CNTR_CONTRACT_AUD")
public class ContractAudit extends BaseEntity {

    @EmbeddedId
    private AuditId auditId;

    @Column(name = "REVTYPE")
    private Long revType;

    @NotEmpty
    @Column(name = "C_NO", nullable = false, length = 200, unique = true)
    private String no;

    @Column(name = "D_DATE")
    private Date date;

    @Column(name = "C_CONTENT")
    private String content;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractAudit2contractTypeByContractTypeId"))
    private ContractType contractType;

    @NotNull
    @Column(name = "F_CONTRACT_TYPE_ID", nullable = false)
    private Long contractTypeId;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractAudit2materialByMaterialId"))
    private Material material;

    @NotNull
    @Column(name = "F_MATERIAL_ID", nullable = false)
    private Long materialId;

//    @NotAudited
//    @Setter(AccessLevel.NONE)
//    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
//    @JoinColumn(name = "F_PARENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractAudit2contractByParentId"))
//    private List<Contract> appendixContracts;

    @Column(name = "F_PARENT_ID")
    private Long parentId;

//    @NotAudited
//    @OneToMany(mappedBy = "contract", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
//    private List<ContractDetail> contractDetails;
}
