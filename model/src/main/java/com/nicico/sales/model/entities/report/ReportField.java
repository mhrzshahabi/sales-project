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
@Table(name = "TBL_REPORT_FIELD")
public class ReportField extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_REPORT_FIELD")
    @SequenceGenerator(name = "SEQ_REPORT_FIELD", sequenceName = "SEQ_REPORT_FIELD", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_REPORT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_reportField2Report"))
    private Report report;

    @NotNull
    @Column(name = "F_REPORT_ID", nullable = false)
    private Long reportId;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @NotNull
    @Column(name = "C_TITLE_FA", nullable = false)
    private String titleFA;

    @NotNull
    @Column(name = "C_TITLE_EN", nullable = false)
    private String titleEN;

    @I18n
    @Transient
    private String title;

    @NotNull
    @Column(name = "C_TYPE", nullable = false)
    private String type;

    @NotNull
    @Column(name = "B_HIDDEN", nullable = false)
    private Boolean hidden;

    @NotNull
    @Column(name = "B_CAN_FILTER", nullable = false)
    private Boolean canFilter;
}
