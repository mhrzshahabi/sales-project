package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Audited
@Entity
@Table(name = "TBL_WARH_DEPOT")
public class Depot extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_DEPOT")
    @SequenceGenerator(name = "SEQ_WARH_DEPOT", sequenceName = "SEQ_WARH_DEPOT", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_STORE_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_depot2storeByStoreId"))
    private Store store;

    @NotNull
    @Column(name = "F_STORE_ID", nullable = false)
    private Long storeId;
}
