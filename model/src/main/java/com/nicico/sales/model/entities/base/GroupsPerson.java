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
@Table(name = "TBL_GROUPS_PERSON", schema = "SALES", uniqueConstraints = @UniqueConstraint(columnNames = {"GROUPS_ID", "PERSON_ID"}))
public class GroupsPerson extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_GROUPS_PERSON")
    @SequenceGenerator(name = "SEQ_GROUPS_PERSON", sequenceName = "SALES.SEQ_GROUPS_PERSON")
    @Column(name = "ID", precision = 10)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "GROUPS_ID", nullable = false, insertable = false, updatable = false)
    private Groups groups;

    @Column(name = "GROUPS_ID")
    private Long groupsId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PERSON_ID", nullable = false, insertable = false, updatable = false)
    private Person person;

    @Column(name = "PERSON_ID")
    private Long personId;

    @Column(name = "REMARK", length = 200)
    private String desc;

}