package com.nicico.sales.model.entities.warehouse;


import com.nicico.sales.model.entities.base.MaterialItem;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
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
@Table(name = "TBL_WARH_TOZIN")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class TozinTable extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_TOZIN")
    @SequenceGenerator(name = "SEQ_WARH_TOZIN", sequenceName = "SEQ_WARH_TOZIN", allocationSize = 1)
    private Long id;
    @NotEmpty
    @Column(name = "TOZINE_ID", nullable = false, unique = true)
    private String tozinId;
    @Column(name = "B_IS_IN_VIEW", nullable = false, columnDefinition = "number default 1")
    private final Boolean isInView = true;
    @Column(name = "SOURCEID", nullable = false)
    private Long sourceId;
    @Setter(AccessLevel.NONE)
    @JoinColumn(name = "SOURCEID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "f_tozinTable2materialItemBySOURCEID"))
    @ManyToOne(fetch = FetchType.LAZY)
    private Warehouse sourceWarehouse;
    @Column(name = "TARGETID", nullable = false)
    private Long targetId;
    @Setter(AccessLevel.NONE)
    @JoinColumn(name = "TARGETID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "f_tozinTable2materialItemByTARGETID"))
    @ManyToOne(fetch = FetchType.LAZY)
    private Warehouse targetWarehouse;
    @Column(name = "CARD_ID")
    private String cardId;
    @Column(name = "HAVCODE")
    private String haveCode;
    @Column(name = "WAZN", nullable = false)
    private Long vazn;
    @Column(name = "DAT", nullable = false)
    private String date;
    @Column(name = "CTRL_DESC_OUT", length = 1000)
    private String ctrlDescOut;
    @Column(name = "PLAK", nullable = false)
    private String plak;
    @Column(name = "DRVNAME", nullable = false)
    private String driverName;

    @NotNull
    @Column(name = "GDSCODE", nullable = false)
    private Long codeKala;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @JoinColumn(name = "GDSCODE", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "f_tozinTable2materialItemByGDSCODE"))
    @ManyToOne(fetch = FetchType.LAZY)
    private MaterialItem materialItem;

    @Column(name = "CONTENER_NO3")
    private String containerNo3;
    @OneToMany(mappedBy = "destinationTozin", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceDetail> remittanceDetailsAsDestination;

    @OneToMany(mappedBy = "sourceTozin", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceDetail> remittanceDetailsAsSource;

}
