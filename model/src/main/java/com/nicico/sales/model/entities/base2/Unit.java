package com.nicico.sales.model.entities.base2;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Audited
@Entity
@Table(name = "TBL_WARH_UNIT")
public class Unit extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_UNIT")
    @SequenceGenerator(name = "SEQ_WARH_UNIT", sequenceName = "SEQ_WARH_UNIT", allocationSize = 1)
    private Long id;
}
