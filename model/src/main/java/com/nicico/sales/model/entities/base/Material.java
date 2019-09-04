package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
public class Material extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MATERIAL_SEQ")
    @SequenceGenerator(name = "MATERIAL_SEQ", sequenceName = "SEQ_MATERIAL_ID",allocationSize = 1)
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "c_DESCL", nullable = false, length = 1000)
    private String descl;

    @Column(name = "c_DESCP", nullable = false, length = 1000)
    private String descp;

    @Column(name = "c_CODE", nullable = false, length = 20)
    private String code;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UNIT_ID", nullable = false, insertable = false, updatable = false)
    private Unit unit;

    @Column(name = "UNIT_ID")
    private Long unitId;
}
