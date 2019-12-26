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
public class ShipmentMoistureItemDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long shipmentMoistureHeaderId;
	private Long lotNo;
	private Double wetWeight;
	private Double moisturePercent;
	private Double dryWeight;
	private Double totalH2oWeight;



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentMoistureItemInfo")
	public static class Info extends ShipmentMoistureItemDTO {
		private Long id;
		private ShipmentMoistureHeaderDTO shipmentMoistureHeader;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentMoistureItemCreateRq")
	public static class Create extends ShipmentMoistureItemDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentMoistureItemUpdateRq")
	public static class Update extends ShipmentMoistureItemDTO {
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
	@ApiModel("ShipmentMoistureItemDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ShipmentMoistureItemSpecRs")
	public static class ShipmentMoistureItemSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ShipmentMoistureItemDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
