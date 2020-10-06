package com.nicico.sales.model.entities.report;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.I18n;
import com.nicico.sales.model.enumeration.ReportType;
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
@Table(name = "TBL_REPORT")
public class Report extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_REPORT")
    @SequenceGenerator(name = "SEQ_REPORT", sequenceName = "SEQ_REPORT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_TITLE_FA", nullable = false)
    private String titleFA;

    @NotNull
    @Column(name = "C_TITLE_EN", nullable = false)
    private String titleEN;

    @I18n
    @NotNull
    @Transient
    private String title;

    @NotNull
    @Column(name = "C_REST_URL", nullable = false)
    private String restUrl;

    @NotNull
    @Column(name = "C_REST_NAME_FA", nullable = false)
    private String restNameFA;

    @NotNull
    @Column(name = "C_REST_NAME_EN", nullable = false)
    private String restNameEN;

    @I18n
    @NotNull
    @Transient
    private String restName;

    @NotNull
    @Column(name = "C_REST_METHOD", nullable = false)
    private String restMethod;

    @Column(name = "C_REPORT_TYPE")
    private ReportType reportType;

    @Column(name = "C_FILE")
    private String file;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "REPORT_GROUP_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_report2ReportGroup"))
    private ReportGroup reportGroup;

    @NotNull
    @Column(name = "REPORT_GROUP_ID", nullable = false)
    private Long reportGroupId;

}
