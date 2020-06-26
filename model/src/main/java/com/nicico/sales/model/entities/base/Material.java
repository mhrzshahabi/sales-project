package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_MATERIAL")
public class Material extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_MATERIAL")
    @SequenceGenerator(name = "SEQ_MATERIAL", sequenceName = "SEQ_MATERIAL", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_DESCL", nullable = false, length = 1000)
    private String descl;

    @Column(name = "c_DESCP", nullable = false, length = 1000)
    private String descp;

    @Column(name = "c_CODE", nullable = false, length = 20)
    private String code;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UNIT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "material2unit"))
    private Unit unit;

    @Column(name = "UNIT_ID")
    private Long unitId;

    @Column(name = "C_ABBREVIATION", nullable = false)
    private String abbreviation;


}
