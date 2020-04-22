package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.base.ContractDetail;
import com.nicico.sales.model.entities.base.Material;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Audited
@Entity
@Table(name = "TBL_CNTR_CONTRACT")
public class Contract2 extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT", sequenceName = "SEQ_CNTR_CONTRACT", allocationSize = 1)
    private Long id;

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
    @JoinColumn(name = "F_CONTRACT_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contract2contractTypeByContractTypeId"))
    private ContractType contractType;

    @NotNull
    @Column(name = "F_CONTRACT_TYPE_ID", nullable = false)
    private Long contractTypeId;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contract2materialByMaterialId"))
    private Material material;

    @NotNull
    @Column(name = "F_MATERIAL_ID", nullable = false)
    private Long materialId;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "F_PARENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contract2contractByParentId"))
    private List<Contract2> appendixContracts;

    @Column(name = "F_PARENT_ID")
    private Long parentId;

    @NotAudited
    @OneToMany(mappedBy = "contract", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<ContractDetail> contractDetails;
}