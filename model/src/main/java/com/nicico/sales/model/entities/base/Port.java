package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import static org.hibernate.envers.RelationTargetAuditMode.NOT_AUDITED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_PORT")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class Port extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PORT")
    @SequenceGenerator(name = "SEQ_PORT", sequenceName = "SEQ_PORT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Audited(targetAuditMode = NOT_AUDITED)
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COUNTRY_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "port2country"))
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;

    @NotNull
    @Column(name = "C_PORT", length = 4000, nullable = false)
    private String port;

    @Column(name = "C_LOA")
    private String loa;

    @Column(name = "C_BEAM")
    private String beam;

    @Column(name = "C_ARRIVAL")
    private String arrival;

}
