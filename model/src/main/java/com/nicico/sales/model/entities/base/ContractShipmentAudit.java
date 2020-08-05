package com.nicico.sales.model.entities.base;

import lombok.*;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect(
        "SELECT" +
                " *" +
                " FROM" +
                " TBL_CONTRACT_SHIPMENT_AUD"
)
public class ContractShipmentAudit {

    @EmbeddedId
    private ContractShipmentAuditId id;
    @Column(name = "REVTYPE")
    private Long revType;
    @Column(name = "d_created_date", nullable = false, updatable = false)
    private Date createdDate;
    @Column(name = "c_created_by", nullable = false, updatable = false)
    private String createdBy;
    @Column(name = "d_last_modified_date")
    private Date lastModifiedDate;
    @Column(name = "c_last_modified_by")
    private String lastModifiedBy;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTRACT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "Contractship2contract"))
    private Contract contract;
    @Column(name = "CONTRACT_ID")
    private Long contractId;
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @NotAudited
    @JoinColumn(name = "LOAD_PORT_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "Contractshipaud2loadport"))
    private Port loadPort;
    @Column(name = "LOAD_PORT_ID")
    private Long loadPortId;
    @Column(name = "QUANTITY")
    private Double quantity;
    @Column(name = "SEND_DATE")
    private Date sendDate;
    @Column(name = "TOLORANCE")
    private Long tolorance;

    @Getter
    @EqualsAndHashCode(callSuper = false)
    @Embeddable
    public static class ContractShipmentAuditId implements Serializable {
        @Column(name = "ID")
        private Long id;

        @Column(name = "REV")
        private Long rev;
    }

}
