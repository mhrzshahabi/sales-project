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
@Table(name = "TBL_WAREHOUSE_ISSUE_CATHODE")
public class WarehouseIssueCathode extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_ISSUE")
	@SequenceGenerator(name = "SEQ_ISSUE", sequenceName = "SEQ_ISSUE")
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_ID", insertable = false, updatable = false)
	private Shipment Shipment;

	@Column(name = "SHIPMENT_ID")
	private Long shipmentId;

	@Column(name = "BIJAK")
	private String bijak;

	@Column(name = "CONTAINER_NO",length = 50)
	private String containerNo;

	@Column(name = "AMOUNT_CUSTOM")
	private Double amountCustom;

	@Column(name = "AMOUNT_PMS")
	private Double amountPms;

	@Column(name = "SEALED_CUSTOM",length = 50)
	private String sealedCustom;

	@Column(name = "SEALED_SHIP",length = 50)
	private String sealedShip;

	@Column(name = "EMPTY_WEIGHT")
	private Double emptyWeight;

    @Column(name = "BUNDLE")
    private String bundle;

    @Column(name = "SHEET")
    private String sheet;

	@Column(name = "TOTAL_AMOUNT")
	private Double totalAmount;

}