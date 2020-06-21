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
@Table(name = "TBL_GROUPS")
public class Groups extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_GROUPS")
    @SequenceGenerator(name = "SEQ_GROUPS", sequenceName = "SEQ_GROUPS", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "GROUPS_NAME", nullable = false, length = 200)
    private String groupsName;

}
