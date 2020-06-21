package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_INCOTERM")
public class Incoterm extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_INCOTERM")
    @SequenceGenerator(name = "SEQ_CNTR_INCOTERM", sequenceName = "SEQ_CNTR_INCOTERM", allocationSize = 1)
    private Long id;

    @NotEmpty
    @Column(name = "C_TITLE", nullable = false, length = 200)
    private String title;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_INCOTERM_VERSION_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_incoterm2incotermVersionByIncotermVersionId"))
    private IncotermVersion incotermVersion;

    @Column(name = "F_INCOTERM_VERSION_ID")
    private Long incotermVersionId;

    @Column(name = "D_PUBLISH_DATE")
    private Date publishDate;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;

    @OneToMany(mappedBy = "incoterm", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<IncotermRules> incotermRules;

    @OneToMany(mappedBy = "incoterm", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<IncotermSteps> incotermSteps;
}
