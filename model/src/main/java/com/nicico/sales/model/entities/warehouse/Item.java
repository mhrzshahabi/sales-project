package com.nicico.sales.model.entities.warehouse;

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
@Table(name = "TBL_WARH_ITEM")
public class Item extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_ITEM")
    @SequenceGenerator(name = "SEQ_WARH_ITEM", sequenceName = "SEQ_WARH_ITEM", allocationSize = 1)
    private Long id;
}
