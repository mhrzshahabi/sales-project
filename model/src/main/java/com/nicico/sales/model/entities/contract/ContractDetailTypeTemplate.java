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
@Table(name = "TBL_CNTR_CONTRACT_DETAIL_TYPE_TEMPLATE")
public class ContractDetailTypeTemplate extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_TEMPLATE")
    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_TEMPLATE", sequenceName = "SEQ_CNTR_CONTRACT_DETAIL_TYPE_TEMPLATE", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_CODE", nullable = false, length = 200, unique = true)
    private String code;

    @NotEmpty
    @Column(name = "C_CONTENT", nullable = false, columnDefinition = "TEXT")
    private String content;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_DETAIL_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_contractDetailTypeTemplate2contractDetailTypeByContractDetailTypeId"))
    private ContractDetailType contractDetailType;

    @NotNull
    @Column(name = "F_CONTRACT_DETAIL_TYPE_ID", nullable = false)
    private Long contractDetailTypeId;
}
