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
@Table(name = "TBL_SHIPMENT_HEADER")
public class ShipmentHeader extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_SHIPMENT_HEADER")
	@SequenceGenerator(name = "SEQ_SHIPMENT_HEADER", sequenceName = "SEQ_SHIPMENT_HEADER")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "DESCRIPTION")
	private String description;

	@Column(name = "SHIPMENT_HEADER_DATE")
	private String shipmentHeaderDate;

}
