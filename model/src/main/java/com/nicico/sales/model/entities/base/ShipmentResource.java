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
@Table(name = "TBL_SHIPMENT_RESOURCE")
public class ShipmentResource extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_RESOURCE")
	@SequenceGenerator(name = "SEQ_SHIPMENT_RESOURCE", sequenceName = "SEQ_SHIPMENT_RESOURCE")
	@Column(name = "ID")
	private Long id;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SHIPMENT_HEADER_ID", nullable = false, insertable = false, updatable = false)
	private ShipmentHeader shipmentHeader;

	@Column(name = "SHIPMENT_HEADER_ID")
	private Long shipmentHeaderId;

	@Setter(AccessLevel.NONE)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CONTACT_ID", nullable = false, insertable = false, updatable = false)
	private Contact contact;

	@Column(name = "CONTACT_ID")
	private Long contactId;

	@Column(name = "DESCRIPTION", length = 4000)
	private String description;
}
