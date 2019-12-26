package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
public class ShipmentAssayHeaderDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long shipmentId;
	private Long inspectionByContactId;
	private String description;
	private String location;
	private String inspectionDate;
	private Double averageCuPercent;
	private Double averageAuPercent;
	private Double averageAgPercent;
	private Double totalDryWeight;


	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayHeaderInfo")
	public static class Info extends ShipmentAssayHeaderDTO {
		private Long id;
		private ShipmentDTO shipment;
		private ContactDTO inspectionByContact;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayHeaderCreateRq")
	public static class Create extends ShipmentAssayHeaderDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayHeaderUpdateRq")
	public static class Update extends ShipmentAssayHeaderDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayHeaderDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ShipmentAssayHeaderSpecRs")
	public static class ShipmentAssayHeaderSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ShipmentAssayHeaderDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
