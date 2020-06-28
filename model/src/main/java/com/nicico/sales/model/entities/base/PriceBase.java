package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.warehouse.Element;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_PRICE_BASE", uniqueConstraints = @UniqueConstraint(name = "element_priceBaseReference_priceDate_UNIQUE",
        columnNames = {"F_ELEMENT_ID", "N_PRICE_BASE_REFERENCE", "D_PRICE_DATE"}))
public class PriceBase extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PRICE_BASE")
    @SequenceGenerator(name = "SEQ_PRICE_BASE", sequenceName = "SEQ_PRICE_BASE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "D_PRICE_DATE")
    private Date priceDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_ELEMENT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "PriceBase2ElementByElementId"))
    private Element element;

    @Column(name = "F_ELEMENT_ID")
    private Long elementId;

    @Column(name = "N_PRICE_BASE_REFERENCE")
    private PriceBaseReference priceBaseReference;

    @Column(name = "N_PRICE", precision = 5, scale = 10)
    private BigDecimal price;

}
