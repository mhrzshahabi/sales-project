package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Material;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CONTRACT_DETAIL_TYPE")
public class ContractDetailType extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL_TYPE")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL_TYPE", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL_TYPE", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_CODE", nullable = false)
    private String code;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "FK_ContractDetailType2MaterialByMaterialId"))
    private Material material;

    @NotNull
    @Column(name = "F_MATERIAL_ID", nullable = false)
    private Long materialId;

    @NotEmpty
    @Column(name = "C_TITLE_FA", nullable = false)
    private String titleFa;

    @NotEmpty
    @Column(name = "C_TITLE_EN", nullable = false)
    private String titleEn;

    @OneToMany(mappedBy = "contractDetailType", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<ContractDetailTypeParam> contractDetailTypeParams;

    @OneToMany(mappedBy = "contractDetailType", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<ContractDetailTypeTemplate> contractDetailTypeTemplates;
}
