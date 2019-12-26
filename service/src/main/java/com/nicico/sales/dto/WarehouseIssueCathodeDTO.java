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
public class WarehouseIssueCathodeDTO {
	private Long shipmentId;
	private String bijak;
	private String bijakIds;
	private String containerNo;
	private Double amountCustom;
	private Double amountPms;
	private String sealedCustom;
	private String sealedShip;
	private Double emptyWeight;
    private String bundle;
    private String sheet;
	private Double totalAmount;



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseIssueCathodeInfo")
	public static class Info extends WarehouseIssueCathodeDTO {
		private Long id;
		private ShipmentDTO Shipment;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseIssueCathodeCreateRq")
	public static class Create extends WarehouseIssueCathodeDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseIssueCathodeUpdateRq")
	public static class Update extends WarehouseIssueCathodeDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseIssueCathodeDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("WarehouseIssueCathodeSpecRs")
	public static class WarehouseIssueCathodeSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<WarehouseIssueCathodeDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
