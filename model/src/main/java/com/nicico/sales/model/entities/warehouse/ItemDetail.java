package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_ITEM_DETAIL")
public class ItemDetail extends BaseEntity {

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_ITEM_DETAIL")
//    @SequenceGenerator(name = "SEQ_WARH_ITEM_DETAIL", sequenceName = "SEQ_WARH_ITEM_DETAIL", allocationSize = 1,initialValue = 10000)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "F_ITEM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_itemDetaill2ItemByItemId"))
    private Item item;

    @NotNull
    @Column(name = "F_ITEM_ID", nullable = false)
    private Long itemId;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @Column(name = "C_NAME_EN")
    private String nameEn;

    @Column(name = "C_DESCRIPTION", length = 1500)
    private String description;


}
