package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.JoinFormula;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_REMITTANCE")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class Remittance extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE", sequenceName = "SEQ_WARH_REMITTANCE", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_CODE", nullable = false, unique = true)
    private String code;

    @OneToMany(mappedBy = "remittance", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @OrderBy("date")
    private List<RemittanceDetail> remittanceDetails;

    @Column(name = "C_DESCRIPTION", length = 1000)
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_shipment_id",
            foreignKey = @ForeignKey(name = "FK_remittance_to_shipment"),
            insertable = false,
            updatable = false
    )
    private Shipment shipment;

    //    @NotNull
    @Column(name = "F_shipment_id")
    private Long shipmentId;

    @NotAudited
    @Formula("(select nvl(dtozin.dat,stozin.DAT) from TBL_WARH_REMITTANCE_DETAIL rd " +
            "left join TBL_WARH_TOZIN dtozin on rd.F_DESTINATION_TOZINE_ID = dtozin.ID " +
            "inner join TBL_WARH_TOZIN stozin on rd.F_SOURCE_TOZINE_ID = stozin.ID " +
            "where rd.F_REMITTANCE_ID=id and ROWNUM=1 )")
    private String date;


    @NotAudited
    @Formula("(select  nvl2( max(vrd.F_REMITTANCE_ID),1,0) from TBL_WARH_REMITTANCE_DETAIL vrd \n" +
            "    left join VIEW_WARH_INVENTORY vi on vrd.F_INVENTORY_ID=vi.ID \n" +
            "    where vrd.F_REMITTANCE_ID=id and vi.WEIGHT>0 and vrd.F_REMITTANCE_ID in \n" +
            "        (select vrd.F_REMITTANCE_ID from TBL_WARH_REMITTANCE_DETAIL vrd \n" +
            "            left join VIEW_WARH_INVENTORY vi on vrd.F_INVENTORY_ID=vi.ID \n" +
            "            where vrd.F_REMITTANCE_ID=id and vi.WEIGHT=0))")

    private Boolean hasRemainedInventory;

    @NotAudited
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinFormula("(select tt.id " +
            "from TBL_WARH_REMITTANCE r " +
            "        left  join TBL_WARH_REMITTANCE_DETAIL rds on r.ID = rds.F_REMITTANCE_ID " +
            " and rds.F_DESTINATION_TOZINE_ID is not null " +
            "        left join  TBL_WARH_REMITTANCE_DETAIL rdd on r.id = rdd.F_REMITTANCE_ID " +
            "         join TBL_WARH_TOZIN tt on nvl(rds.F_DESTINATION_TOZINE_ID,rdd.F_SOURCE_TOZINE_ID) = tt.id " +
            "where ROWNUM =1 and r.ID=id )")
    private TozinTable tozinTable;
    @Audited(targetAuditMode = NOT_AUDITED)
    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_PACKING_CONTAINER_id",
            foreignKey = @ForeignKey(name = "FK_remittance_to_packing_container"),
            insertable = false,
            updatable = false
    )
    private PackingContainer packingContainer;
    @Column(name = "F_PACKING_CONTAINER_id")
    private Long packingContainerId;


}
