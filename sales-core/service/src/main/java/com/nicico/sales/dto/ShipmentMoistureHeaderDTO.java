package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.Shipment;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ShipmentMoistureHeaderDTO {
	private Shipment shipment;
	@NotNull
	@ApiModelProperty(required = true)
	private Long shipmentId;
	private Contact inspectionByContact;
	private Long inspectionByContactId;
	private String description;
	private String location;
	private String inspectionDate;
	private Double totalWetWeight;
	private Double averageMoisturePercent;
	private Double totalDryWeight;
	private Double totalH2oWeight;

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentMoistureHeaderInfo")
	public static class Info extends ShipmentMoistureHeaderDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentMoistureHeaderCreateRq")
	public static class Create extends ShipmentMoistureHeaderDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentMoistureHeaderUpdateRq")
	public static class Update extends ShipmentMoistureHeaderDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentMoistureHeaderDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ShipmentMoistureHeaderSpecRs")
	public static class ShipmentMoistureHeaderSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ShipmentMoistureHeaderDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
