package com.nicico.sales.model.entities.contract;


import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Immutable;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Immutable
@Entity
@Table(name = "TBL_CONTRACT_DISCOUNT")
public class ContractDiscount extends BaseEntity {

    @Id
    private Long id;

    @Column(name = "DISCOUNT", nullable = false)
    private Double discount;

    /*  discount contains upperBound */
    @Column(name = "UPPER_BOUND", nullable = false)
    private Double upperBound;

    /*  discount does NOT contain lowerBound */
    @Column(name = "LOWER_BOUND", nullable = false)
    private Double lowerBound;


}
