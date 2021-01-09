package com.nicico.sales.model.entities.report;

import com.nicico.sales.model.annotation.I18n;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.ReportSource;
import com.nicico.sales.model.enumeration.ReportType;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@I18n
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_REPORT")
public class Report extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_REPORT")
    @SequenceGenerator(name = "SEQ_REPORT", sequenceName = "SEQ_REPORT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_TITLE_FA", nullable = false, unique = true)
    private String titleFA;

    @NotNull
    @Column(name = "C_TITLE_EN", nullable = false, unique = true)
    private String titleEN;

    @I18n
    @Transient
    private String title;

    @NotNull
    @Column(name = "C_SOURCE", nullable = false)
    private String source;

    @NotNull
    @Column(name = "C_PERMISSION_BASE_KEY", nullable = false, unique = true)
    private String permissionBaseKey;

    @NotNull
    @Column(name = "C_NAME_FA", nullable = false)
    private String nameFA;

    @NotNull
    @Column(name = "C_NAME_EN", nullable = false)
    private String nameEN;

    @I18n
    @Transient
    private String name;

    @Column(name = "C_REST_METHOD")
    private String restMethod;

    @Column(name = "C_CRITERIA")
    private String criteria;

    @NotNull
    @Column(name = "C_REPORT_SOURCE", nullable = false)
    private ReportSource reportSource;

    @NotNull
    @Column(name = "C_REPORT_TYPE", nullable = false)
    private ReportType reportType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REPORT_GROUP_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_report2ReportGroup"))
    private ReportGroup reportGroup;

    @NotNull
    @Column(name = "F_REPORT_GROUP_ID", nullable = false)
    private Long reportGroupId;

    @OneToMany(mappedBy = "report", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ReportField> reportFields;
}
