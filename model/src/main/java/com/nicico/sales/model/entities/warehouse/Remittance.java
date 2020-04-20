package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

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
@Table(name = "TBL_WARH_REMITTANCE")
public class Remittance extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE", sequenceName = "SEQ_WARH_REMITTANCE", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_TYPE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_remittance2remittanceTypeByRemittanceTypeId"))
    private RemittanceType remittanceType;

    @NotNull
    @Column(name = "F_REMITTANCE_TYPE_ID", nullable = false)
    private Long remittanceTypeId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_DEPOT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_remittance2depotByDepotId"))
    private Depot depot;

    @NotNull
    @Column(name = "F_DEPOT_ID", nullable = false)
    private Long depotId;

    @OneToMany(mappedBy = "remittance", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceDetail> remittanceDetails;
}
