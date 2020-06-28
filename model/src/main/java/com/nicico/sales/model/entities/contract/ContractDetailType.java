package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
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

    @Column(name = "C_MATERIAL", nullable = false, unique = true)
    private Long material;

    @NotEmpty
    @Column(name = "C_CODE", nullable = false, unique = true)
    private String code;

    @NotEmpty
    @Column(name = "C_TITLE_FA", nullable = false)
    private String titleFa;

    @NotEmpty
    @Column(name = "C_TITLE_EN", nullable = false)
    private String titleEn;

    @OneToMany(mappedBy = "contractDetailType", fetch = FetchType.LAZY)
    private List<ContractDetailTypeParam> contractDetailTypeParams;

    @OneToMany(mappedBy = "contractDetailType", fetch = FetchType.LAZY)
    private List<ContractDetailTypeTemplate> contractDetailTypeTemplates;
}
