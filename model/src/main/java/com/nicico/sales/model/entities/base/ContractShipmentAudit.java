package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;
import org.hibernate.envers.Audited;
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

    @Getter
    @EqualsAndHashCode(callSuper = false)
    @Embeddable
    public static class ContractShipmentAuditId implements Serializable {
        @Column(name = "ID")
        private Long id;

        @Column(name = "REV")
        private Long rev;
    }

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

	@Column(name = "PLAN", length = 20)
	private String plan;

	@Column(name = "SHIPMENT_ROW", length = 5)
	private Long shipmentRow;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@NotAudited
	@JoinColumn(name = "DISCHARGE", nullable = false, insertable = false, updatable = false,foreignKey = @ForeignKey(name = "Contractship2dischargeport"))
	private Port discharge;

	@Column(name = "DISCHARGE")
	private Long dischargeId;

	@Column(name = "ADDRESS", length = 4000)
	private String address;

	@Column(name = "AMOUNT")
	private Double amount;

	@Column(name = "SEND_DATE", length = 50)
	private String sendDate;

	@Column(name = "DURATION")
	private Long duration;

	@Column(name = "TOLORANCE")
	private Long tolorance;

}
