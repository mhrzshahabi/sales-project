package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

//بارنامه
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_PACKING_CONTAINER",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"F_PACKAGING_LIST","C_CONTAINER_No"}, name = "UC_F_PACKAGING_LIST_C_CONTAINER_No"),
        }
)
public class PackingContainer extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PACKING_CONTAINER")
    @SequenceGenerator(name = "SEQ_PACKING_CONTAINER", sequenceName = "SEQ_PACKING_CONTAINER", allocationSize = 1, initialValue = 100000)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_PACKAGING_LIST",
            foreignKey = @ForeignKey(name = "FK_PACKAGIN_CONTAINER2PACKING_LIST"),
            insertable = false,
            updatable = false
    )
    private PackingList packingList;

    @Column(name = "F_PACKAGING_LIST",nullable = false)
    private Long packingListId;


   @Column(name="C_CONTAINER_No",nullable = false)
    private String containerNo;

   @Column(name="C_SEAL_No") //shomare polopmp
    private String sealNo;

   @Column(name="N_LADING_DATE",nullable = false)
    private Long ladingDate;

   @Column(name="N_PACKAGE_COUNT")//تعداد بسته لات
    private Long packageCount;

    @Column(name="N_sub_PACKAGE_COUNT")// تعداد ورق بشکه
    private Long subpackageCount;


     @Column(name="N_STRAP_WEIGHT")// وزن تسمه
    private Long strapWeight;

     @Column(name="N_PALLET_Count")// tedad pllet
    private Long palletCount;

     @Column(name="N_PALLET_WEIGHT")// وزن pallet
    private Long palletWeight;

     @Column(name="N_wood_WEIGHT")// وزن wood cathod falle
    private Long woodWeight;

  @Column(name="N_BARREL_WEIGHT")// وزن boshkeh
    private Long barrelWeight;


 @Column(name="N_CONTAINER_WEIGHT")// وزن boshkeh
    private Long containerWeight;


@Column(name="N_CONTENT_WEIGHT",nullable = false)// vazn mohteva, hamoon vaznie ke baskool mige. mishe vazne kolli bar bedoon container
    private Long contentWeight;

    @Column(name="N_vgm_WEIGHT")// content + container
    private Long vgmWeight;


@Column(name="N_NET_WEIGHT",nullable = false)// vazn mohteva, hamoon vaznie ke baskool mige. mishe vazne kolli bar bedoon container
    private Long netWeight;

@Column(name="C_DESCRIPTION",length = 2000)
    private String description;


}
