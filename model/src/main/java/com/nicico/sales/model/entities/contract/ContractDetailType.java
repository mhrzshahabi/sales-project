package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.annotation.I18n;
import com.nicico.sales.model.entities.base.Material;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@I18n
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
    private String titleFA;

    @NotEmpty
    @Column(name = "C_TITLE_EN", nullable = false)
    private String titleEN;

    @I18n
    @Transient
    private String title;

    @OneToMany(mappedBy = "contractDetailType", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ContractDetailTypeParam> contractDetailTypeParams;

    @OneToMany(mappedBy = "contractDetailType", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ContractDetailTypeTemplate> contractDetailTypeTemplates;
}
