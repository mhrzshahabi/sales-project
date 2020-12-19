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


    @Audited(targetAuditMode = NOT_AUDITED)
    @OneToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(name = "id",insertable = false,updatable = false)
    private RemittanceView remittanceView;

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
