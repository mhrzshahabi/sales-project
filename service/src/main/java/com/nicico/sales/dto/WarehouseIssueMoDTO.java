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
public class WarehouseIssueMoDTO {
	private Long shipmentId;
	private Long WarehouseLotId;
	private String containerNo;
	private Double amountCustom;
	private String sealedCustom;
	private String sealedInspector;
	private String sealedShip;
	private Double emptyWeight;
	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseIssueMoInfo")
	public static class Info extends WarehouseIssueMoDTO {
		private Long id;
		private ShipmentDTO Shipment;
		private WarehouseLotDTO warehouseLot;
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
	@ApiModel("WarehouseIssueMoCreateRq")
	public static class Create extends WarehouseIssueMoDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseIssueMoUpdateRq")
	public static class Update extends WarehouseIssueMoDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseIssueMoDeleteRq")
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
	@ApiModel("WarehouseIssueMoSpecRs")
	public static class WarehouseIssueMoSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<WarehouseIssueMoDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
