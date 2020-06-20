package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_ITEM")
public class Item extends BaseEntity {

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_ITEM")
//    @SequenceGenerator(name = "SEQ_WARH_ITEM", sequenceName = "SEQ_WARH_ITEM", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @Column(name = "C_NAME_EN")
    private String nameEn;

    @NotNull
    @Column(name = "B_IS_BULK")
    private Boolean isBulk = false;

    @Column(name = "C_DESCRIPTION", length = 1500)
    private String description;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "F_DEFAULT_UNIT_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "fk_item2unitByunitId"))
    private Unit unit;

    @Column(name = "F_DEFAULT_UNIT_ID")
    private Long unitId;

    @OneToMany(mappedBy = "item", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<ItemElement> itemElements;

    @OneToMany(mappedBy = "item", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<ItemDetail> itemDetails;


}
