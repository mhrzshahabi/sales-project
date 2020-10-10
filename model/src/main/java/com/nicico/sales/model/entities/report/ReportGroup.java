package com.nicico.sales.model.entities.report;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.annotation.I18n;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@I18n
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_REPORT_GROUP")
public class ReportGroup extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_REPORT_GROUP")
    @SequenceGenerator(name = "SEQ_REPORT_GROUP", sequenceName = "SEQ_REPORT_GROUP", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_NAME_FA", nullable = false)
    private String nameFA;

    @NotNull
    @Column(name = "C_NAME_EN", nullable = false)
    private String nameEN;

    @I18n
    @NotNull
    @Transient
    private String name;

    @NotNull
    @Column(name = "C_ORDER", nullable = false)
    private String order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_PARENT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_reportGroup2ReportGroup"))
    private ReportGroup parent;

    @Column(name = "F_PARENT_ID")
    private Long parentId;
}
