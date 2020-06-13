package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CONTRACT_DETAIL_TYPE_PARAM_VALUE")
public class ContractDetailTypeParamValue extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_PARAM_VALUE")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_PARAM_VALUE", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_PARAM_VALUE", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_VALUE", nullable = false)
    private String value;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_TYPE_PARAM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailTypeParamValue2contractDetailTypeParamByContractDetailTypeParamId"))
    private ContractDetailTypeParam contractDetailTypeParam;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_TYPE_PARAM_ID", nullable = false)
    private Long contractDetailTypeParamId;

    @Column(name = "C_CONTRACT_NUMBER")
    private String ContractNumber;
}
