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
    @JoinColumns({
            @JoinColumn(name = "F_TOZIN_ID", insertable = false, updatable = false,
                    referencedColumnName = "TOZINE_ID",
                    foreignKey = @ForeignKey(name = "fk_remittance_tozin2sourceTozinAsSourceBySourceTozinId")),
            @JoinColumn(name = "F_TOZIN_SOURCEE", insertable = false, updatable = false,
                    referencedColumnName = "SOURCEE",
                    foreignKey = @ForeignKey(name = "fk_remittance_tozin2sourceTozinAsSourceBySource")),
            @JoinColumn(name = "F_TOZIN_GDSNAME", insertable = false, updatable = false,
                    referencedColumnName = "GDSNAME",
                    foreignKey = @ForeignKey(name = "fk_remittance_tozin2sourceTozinAsSourceByGDSNAME")),
            @JoinColumn(name = "F_TOZIN_GDSCODE", insertable = false, updatable = false,
                    referencedColumnName = "GDSCODE",
                    foreignKey = @ForeignKey(name = "fk_remittance_tozin2sourceTozinAsSourceByGDSCODE")),

            @JoinColumn(name = "F_TOZIN_TARGET", insertable = false, updatable = false,
                    referencedColumnName = "TARGET",
                    foreignKey = @ForeignKey(name = "fk_remittance_tozin2sourceTozinAsSourceByTARGET")),

            @JoinColumn(name = "F_TOZIN_CARD_ID", insertable = false, updatable = false,
                    referencedColumnName = "CARD_ID",
                    foreignKey = @ForeignKey(name = "fk_remittance_tozin2sourceTozinAsSourceByCARD_ID")),
    })

    private Tozin2 tozin;

    @NotNull
    @Column(name = "F_TOZIN_ID", nullable = false)
    private String tozinId;
    @NotNull
    @Column(name = "F_TOZIN_SOURCEE", nullable = false)
    private String tozinSource;
    @NotNull
    @Column(name = "F_TOZIN_GDSNAME", nullable = false)
    private String tozinGdsName;
    @NotNull
    @Column(name = "F_TOZIN_GDSCODE", nullable = false)
    private Long tozinGdsCode;
    @NotNull
    @Column(name = "F_TOZIN_TARGET", nullable = false)
    private String tozinTarget;
    @NotNull
    @Column(name = "F_TOZIN_CARD_ID", nullable = false)
    private String tozinCardId;

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
