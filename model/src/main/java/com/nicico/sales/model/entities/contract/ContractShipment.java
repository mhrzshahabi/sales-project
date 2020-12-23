package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CONTRACT_SHIPMENT")
@Audited
@AuditOverride(forClass = BaseEntity.class)
public class ContractShipment extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_SHIPMENT")
    @SequenceGenerator(name = "SEQ_CONTRACT_SHIPMENT", sequenceName = "SEQ_CONTRACT_SHIPMENT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "CONTRACTSHIPMENT2CONTRACT2"))
    private Contract contract;

    @Column(name = "CONTRACT_ID")
    private Long contractId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "LOAD_PORT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "Contractship2loadport"))
    private Port loadPort;

    @Column(name = "LOAD_PORT_ID")
    private Long loadPortId;

    @Column(name = "QUANTITY")
    private Double quantity;

    @Column(name = "SEND_DATE")
    private Date sendDate;

    @Column(name = "TOLORANCE")
    private Double tolerance;

    @Column(name = "N_PARENT_ID")
    private Long parentId;

}
