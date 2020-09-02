package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.Contract2;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.envers.AuditOverride;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Audited
@AuditOverride(forClass = Auditable.class)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CONTRACT_SHIPMENT")
public class ContractShipment extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_SHIPMENT")
    @SequenceGenerator(name = "SEQ_CONTRACT_SHIPMENT", sequenceName = "SEQ_CONTRACT_SHIPMENT", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "CONTRACTSHIPMENT2CONTRACT2"))
    private Contract2 contract;

    @Column(name = "CONTRACT_ID")
    private Long contractId;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "LOAD_PORT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "Contractship2loadport"))
    private Port loadPort;

    @Column(name = "LOAD_PORT_ID")
    private Long loadPortId;

    @Column(name = "QUANTITY")
    private Double quantity;

    @Column(name = "SEND_DATE")
    private Date sendDate;

    @Column(name = "TOLORANCE")
    private Long tolorance;

    @Column(name = "N_PARENT_ID")
        private Long parentId;


}
