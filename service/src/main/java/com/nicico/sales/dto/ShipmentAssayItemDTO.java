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
public class ShipmentAssayItemDTO {

	private Long shipmentAssayHeaderId;
	private Long lotNo;
	private Double cu;
	private Double ag;
	private Double au;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayItemInfo")
	public static class Info extends ShipmentAssayItemDTO {
		private Long id;
		private ShipmentAssayHeaderDTO shipmentAssayHeader;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayItemCreateRq")
	public static class Create extends ShipmentAssayItemDTO {
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayItemUpdateRq")
	public static class Update extends ShipmentAssayItemDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentAssayItemDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ShipmentAssayItemDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
