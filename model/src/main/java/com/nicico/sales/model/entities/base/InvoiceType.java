package com.nicico.sales.model.entities.base;


import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_Invoice_Type")
public class InvoiceType extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_TBL_Invoice_Type")
    @SequenceGenerator(name = "SEQ_TBL_Invoice_Type", sequenceName = "SEQ_TBL_Invoice_Type", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "TITLE", nullable = false, length = 80)
    private String title;


}
