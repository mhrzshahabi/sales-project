package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_WAREHOUSE")
public class Warehouse extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_WAREHOUSE")
    @SequenceGenerator(name = "SEQ_WARH_WAREHOUSE", sequenceName = "SEQ_WARH_WAREHOUSE", allocationSize = 1)
    private Long id;


    @OneToMany(mappedBy = "warehouse", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<Store> stores;
}
