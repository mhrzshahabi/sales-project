package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
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

    @NotNull
    @Column(name = "C_TITLE", nullable = false, length = 200)
    private String title;

    @NotNull
    @Column(name = "N_VERSION", nullable = false)
    private Integer version;

    @Column(name = "D_PUBLISH_DATE")
    private Date publishDate;

    @Column(name = "C_DESCRIPTION", length = 4000)
    private String description;

    @OneToMany(mappedBy = "incoterm", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<IncotermRules> incotermModes;

    @OneToMany(mappedBy = "incoterm", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<IncotermSteps> incotermSteps;
}
