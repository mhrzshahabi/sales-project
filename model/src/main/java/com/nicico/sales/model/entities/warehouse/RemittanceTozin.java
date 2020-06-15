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
@Table(name = "TBL_WARH_REMITTANCE_TOZIN")
public class RemittanceTozin extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE_TOZIN")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE_TOZIN", sequenceName = "SEQ_WARH_REMITTANCE_TOZIN", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @OneToOne(fetch = FetchType.LAZY)

    @JoinColumn(name = "F_TOZIN_ID", insertable = false, updatable = false,
//                    referencedColumnName = "TOZINE_ID",
            foreignKey = @ForeignKey(name = "fk_remittance_tozin2sourceTozinAsSourceBySourceTozinId"))
    private TozinTable tozin;

    @NotNull
    @Column(name = "F_TOZIN_ID", nullable = false)
    private Long tozinId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REMITTANCE_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "fk_remittance_tozinl2remittanceByRemittanceId"))
    private Remittance remittance;

    @NotNull
    @Column(name = "F_REMITTANCE_ID", nullable = false)
    private Long remittanceId;

    @Column(name = "B_IS_SOURCE_TOZIN", nullable = false)
    private Boolean isSourceTozin;

}
